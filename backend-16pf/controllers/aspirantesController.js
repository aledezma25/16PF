const pool = require("../db");
const bcrypt = require("bcrypt");
const logger = require("../utils/logger");

const crearAspirante = async (req, res) => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const {
      cedula,
      nombre,
      correo,
      cargo_aplicado,
      usuario_id,
      usuarios_ids = [],
    } = req.body;

    if (!usuario_id) {
      return res.status(400).json({ error: "usuario_id es requerido" });
    }

    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(cedula.toString(), salt);

    const insertAspiranteQuery = `
      INSERT INTO aspirantes 
        (cedula, nombre, correo, cargo_aplicado, contrasena, creado_en)
      VALUES
        ($1, $2, $3, $4, $5, NOW())
      RETURNING id, cedula, nombre, correo, cargo_aplicado;
    `;
    const result = await client.query(insertAspiranteQuery, [
      cedula,
      nombre,
      correo,
      cargo_aplicado,
      passwordHash,
    ]);

    const aspiranteId = result.rows[0].id;

    const insertRelacionQuery = `
      INSERT INTO usuarios_aspirantes (usuario_id, aspirante_id, creado_en)
      VALUES ($1, $2, NOW())
      ON CONFLICT DO NOTHING;
    `;
    await client.query(insertRelacionQuery, [usuario_id, aspiranteId]);

    for (const uId of usuarios_ids) {
      await client.query(insertRelacionQuery, [uId, aspiranteId]);
    }

    await client.query("COMMIT");

    res.status(201).json({
      message: "Aspirante registrado con éxito y asociado a usuarios",
      aspirante: result.rows[0],
      usuarios_asociados: [usuario_id, ...usuarios_ids],
    });
  } catch (error) {
    await client.query("ROLLBACK");
    logger.error("Error al crear aspirante:", error);

    if (error.code === "23505") {
      return res.status(400).json({
        error: "Ya existe un aspirante con esa cédula o correo",
      });
    }

    res.status(500).json({ error: "Error del servidor" });
  } finally {
    client.release();
  }
};

const obtenerAspirante = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT a.*, c.nombre AS cargo_nombre
       FROM aspirantes a
       LEFT JOIN cargos c ON a.cargo_aplicado = c.id
       WHERE a.id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Aspirante no encontrado" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    logger.error("Error al obtener aspirante:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const obtenerAspirantes = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT a.id, a.cedula, a.nombre, a.correo, a.edad, a.sexo, a.escolaridad, a.cargo_aplicado, a.estado_prueba, a.reporte_pdf, c.nombre AS cargo_nombre, COALESCE(COUNT(r.id), 0) AS total_respuestas FROM aspirantes a LEFT JOIN cargos c ON a.cargo_aplicado = c.id LEFT JOIN respuestas_16pf r ON r.aspirante_id = a.id GROUP BY a.id, c.nombre ORDER BY a.creado_en DESC"
    );
    res.json(result.rows);
  } catch (error) {
    logger.error("Error al obtener aspirantes:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const editarAspirante = async (req, res) => {
  const { id } = req.params;
  const {
    cedula,
    nombre,
    correo,
    edad,
    sexo,
    escolaridad,
    cargo_aplicado,
    usuariosAgregar = [],
    usuariosEliminar = [],
  } = req.body;

  try {
    const updateQuery = `
      UPDATE aspirantes
      SET cedula = $1,
          nombre = $2,
          correo = $3,
          edad = $4,
          sexo = $5,
          escolaridad = $6,
          cargo_aplicado = $7,
          actualizado_en = NOW()
      WHERE id = $8
      RETURNING *;
    `;
    const result = await pool.query(updateQuery, [
      cedula,
      nombre,
      correo,
      edad,
      sexo,
      escolaridad,
      cargo_aplicado,
      id,
    ]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Aspirante no encontrado" });
    }

    if (usuariosEliminar.length > 0) {
      await pool.query(
        `DELETE FROM usuarios_aspirantes
         WHERE aspirante_id = $1
         AND usuario_id = ANY($2::int[])`,
        [id, usuariosEliminar]
      );
    }

    if (usuariosAgregar.length > 0) {
      await pool.query(
        `INSERT INTO usuarios_aspirantes (aspirante_id, usuario_id)
         SELECT $1, UNNEST($2::int[])
         ON CONFLICT DO NOTHING`,
        [id, usuariosAgregar]
      );
    }

    res.json({
      message: "Aspirante actualizado con éxito",
      aspirante: result.rows[0],
    });
  } catch (error) {
    logger.error("Error al actualizar aspirante:", error);
    res.status(500).json({
      error: "Error del servidor",
      detalle: error.message,
    });
  }
};

const obtenerTextoGenerado = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT t.* 
       FROM interpretaciones_ia t
       WHERE t.aspirante_id = $1
       ORDER BY t.generado_en DESC
       LIMIT 1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res
        .status(404)
        .json({ error: "No se encontró texto generado para este aspirante" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    logger.error("Error al obtener texto generado:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const obtenerReportePDF = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT reporte_pdf
       FROM aspirantes
       WHERE id = $1`,
      [id]
    );

    if (result.rows.length === 0 || !result.rows[0].reporte_pdf) {
      return res
        .status(404)
        .json({ error: "No se encontró reporte PDF para este aspirante" });
    }

    res.json({ reporte_pdf: result.rows[0].reporte_pdf });
  } catch (error) {
    logger.error("Error al obtener reporte PDF:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const enviarCorreo = require("../utils/mailer");

const enviarCorreoAspirante = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      `SELECT a.id, a.nombre, a.correo, a.cedula, c.nombre AS cargo_nombre
       FROM aspirantes a
       LEFT JOIN cargos c ON a.cargo_aplicado = c.id
       WHERE a.id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Aspirante no encontrado" });
    }

    const aspirante = result.rows[0];

    const password = aspirante.cedula.toString();

    const linkPrueba = `${process.env.APP}/login`;

    const html = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro en Sistema de Pruebas</title>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;">
    
    <!-- Contenedor principal -->
    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" border="0" style="max-width: 600px; width: 100%; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    
                    <!-- Header con logo -->
                    <tr>
                        <td style="background-color: #4a90e2; padding: 30px 20px; text-align: center; color: white;">
                            <img src="https://susuerte.com/wp-content/uploads/2021/05/logo.png" alt="Logo de la empresa" style="max-width: 120px; height: auto; margin-bottom: 15px; display: block; margin-left: auto; margin-right: auto;" />
                            <h1 style="margin: 0; font-size: 24px; font-weight: bold;">¡Registro Exitoso!</h1>
                            <p style="margin: 10px 0 0 0; font-size: 16px;">Sistema de Evaluación de Aspirantes</p>
                        </td>
                    </tr>
                    
                    <!-- Contenido principal -->
                    <tr>
                        <td style="padding: 30px 20px;">
                            
                            <!-- Saludo -->
                            <h2 style="color: #333; font-size: 20px; margin: 0 0 20px 0;">Hola ${aspirante.nombre},</h2>
                            
                            <!-- Mensaje principal -->
                            <p style="color: #555; font-size: 16px; line-height: 1.6; margin: 0 0 20px 0;">
                                Te confirmamos que has sido registrado exitosamente en nuestro sistema de pruebas para el cargo de 
                                <strong style="color: #4a90e2;">${aspirante.cargo_nombre}</strong>. Como parte del proceso de selección, 
                                realizarás la evaluación <strong>16PF (16 Factores de Personalidad)</strong>, una herramienta psicométrica 
                                reconocida mundialmente.
                            </p>
                            
                            <!-- Sección de acceso -->
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #f8f9fa; border-left: 4px solid #4a90e2; margin: 20px 0;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #333; font-size: 18px; margin: 0 0 15px 0;">Acceso a la Plataforma</h3>
                                        <p style="color: #555; font-size: 16px; line-height: 1.6; margin: 0 0 15px 0;">
                                            Puedes acceder a la plataforma de evaluación haciendo clic en el siguiente enlace:
                                        </p>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="background-color: #4a90e2; border-radius: 6px; padding: 12px 25px;">
                                                    <a href="${linkPrueba}" style="color: white; text-decoration: none; font-weight: bold; font-size: 16px; display: block;">
                                                        🚀 Acceder a la Plataforma
                                                    </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- Credenciales -->
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border: 2px solid #e9ecef; border-radius: 8px; margin: 20px 0;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #333; font-size: 18px; margin: 0 0 15px 0;">Credenciales de Acceso</h3>
                                        
                                        <!-- Usuario -->
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom: 15px;">
                                            <tr>
                                                <td style="padding: 10px 0; border-bottom: 1px solid #f1f3f4;">
                                                    <strong style="color: #495057; font-size: 16px;">Usuario:</strong><br>
                                                    <span style="font-family: monospace; background-color: #f8f9fa; padding: 8px 12px; border-radius: 4px; border: 1px solid #dee2e6; font-size: 14px; color: #495057; display: inline-block; margin-top: 5px;">
                                                        ${aspirante.cedula}
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <!-- Contraseña -->
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="padding: 10px 0;">
                                                    <strong style="color: #495057; font-size: 16px;">Contraseña:</strong><br>
                                                    <span style="font-family: monospace; background-color: #f8f9fa; padding: 8px 12px; border-radius: 4px; border: 1px solid #dee2e6; font-size: 14px; color: #495057; display: inline-block; margin-top: 5px;">
                                                        ${password}
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- Información sobre 16PF -->
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #e8f4f8; border-left: 4px solid #17a2b8; margin: 20px 0;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #333; font-size: 18px; margin: 0 0 15px 0;">Acerca de la Evaluación 16PF</h3>
                                        <p style="color: #555; font-size: 16px; line-height: 1.6; margin: 0;">
                                            El <strong>16PF</strong> es un cuestionario de personalidad que evalúa 16 factores fundamentales del comportamiento humano. 
                                            Esta evaluación nos permitirá identificar tus fortalezas, estilo de trabajo y compatibilidad con el puesto. 
                                            La prueba tiene una duración aproximada de <strong>30-40 minutos</strong> y no tiene respuestas correctas o incorrectas.
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- Aviso importante -->
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px; margin: 20px 0;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <p style="color: #856404; font-size: 16px; line-height: 1.6; margin: 0; font-weight: bold;">
                                            ⚠️ <strong>Importante:</strong> Por favor, inicia sesión y completa tu evaluación 16PF dentro del plazo establecido. 
                                            Te recomendamos responder con honestidad para obtener resultados precisos.
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- Mensaje final -->
                            <p style="color: #555; font-size: 16px; line-height: 1.6; margin: 20px 0 0 0;">
                                Si tienes alguna pregunta sobre la evaluación 16PF o experimentas dificultades técnicas, no dudes en contactarnos. 
                                ¡Te deseamos mucho éxito en tu evaluación de personalidad!
                            </p>
                            
                        </td>
                    </tr>
                    
                    <!-- Footer -->
                    <tr>
                        <td style="background-color: #f8f9fa; padding: 30px 20px; text-align: center; border-top: 1px solid #dee2e6;">
                            <p style="color: #495057; font-size: 16px; margin: 0 0 10px 0;">
                                Saludos cordiales,<br>
                                <strong style="color: #4a90e2;">Equipo de Selección Susuerte S.A.</strong>
                            </p>
                            <p style="color: #6c757d; font-size: 14px; margin: 15px 0 0 0; font-style: italic;">
                                Este es un mensaje automático del sistema. Por favor, no respondas a este correo.
                            </p>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
    
</body>
</html>


    `;

    await enviarCorreo(
      aspirante.correo,
      "Acceso a la plataforma de pruebas 16PF",
      html
    );

    await pool.query(
      "UPDATE aspirantes SET estado_prueba = 'enviado' WHERE id = $1",
      [id]
    );

    res.json({ success: true, message: "Correo enviado y estado actualizado" });
  } catch (error) {
    logger.error("Error al enviar el correo", error);
    res.status(500).json({ error: "Error al enviar correo" });
  }
};

const eliminarAspirante = async (req, res) => {
  try {
    const { id } = req.params;

    const deleteQuery = `
      DELETE FROM aspirantes
      WHERE id = $1
      RETURNING *;
    `;

    const result = await pool.query(deleteQuery, [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Aspirante no encontrado" });
    }

    res.status(200).json({
      message: "Aspirante eliminado con éxito",
      aspirante: result.rows[0],
    });
  } catch (error) {
    logger.error("Error al eliminar aspirante:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const obtenerUsuariosAspirante = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pool.query(
      `SELECT u.id, u.nombre, u.correo
       FROM usuarios_aspirantes ua
       INNER JOIN usuarios u ON u.id = ua.usuario_id
       WHERE ua.aspirante_id = $1`,
      [id]
    );
    res.json(result.rows);
  } catch (error) {
    logger.error("Error al obtener usuarios asociados:", error);
    res.status(500).json({ error: "Error al obtener usuarios asociados" });
  }
};

module.exports = {
  crearAspirante,
  obtenerAspirante,
  obtenerAspirantes,
  editarAspirante,
  obtenerTextoGenerado,
  obtenerReportePDF,
  enviarCorreoAspirante,
  eliminarAspirante,
  obtenerUsuariosAspirante,
};
