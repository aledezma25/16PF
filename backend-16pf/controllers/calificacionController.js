const pool = require("../db");
const { generarInterpretacionIA } = require("./interpretacionIA");
const { generarReporte16pf } = require("../services/pdf.service");
const {
  obtenerCorreosPorAspirante,
  enviarReporte,
} = require("../services/mail.service");
const path = require("path");
const logger = require("../utils/logger");

const calificarPrueba = async (req, res) => {
  const { aspirante_id, enviar_correo } = req.body;
  if (!aspirante_id)
    return res.status(400).json({ error: "aspirante_id es requerido" });

  const client = await pool.connect();
  try {
    const { rows } = await client.query(
      "SELECT COUNT(*) AS total FROM respuestas_16pf WHERE aspirante_id = $1",
      [aspirante_id]
    );
    const total = parseInt(rows[0].total, 10);

    if (total < 187) {
      return res.status(400).json({
        error: `El aspirante solo ha respondido ${total}/187 preguntas. No puede calificar todavía.`,
      });
    }
    await client.query("BEGIN");

    await client.query("DELETE FROM resultados_16pf WHERE aspirante_id = $1", [
      aspirante_id,
    ]);

    const resultadosQuery = `
      WITH puntajes AS (
        SELECT 
            r.aspirante_id,
            cd.factor,
            SUM(cd.puntaje) AS puntaje_total
        FROM respuestas_16pf r
        JOIN clave_detalle_16pf cd 
            ON r.numero_pregunta = cd.numero_pregunta
           AND r.respuesta = cd.opcion
        WHERE r.aspirante_id = $1
        GROUP BY r.aspirante_id, cd.factor
      ),
      calificados AS (
        SELECT 
            f.codigo AS factor,
            f.descripcion AS nombre_factor,
            p.aspirante_id,
            p.puntaje_total,
            b.decatipo AS decatipo_sin_correccion,
            r.regla
        FROM puntajes p
        JOIN factores_16pf f 
            ON p.factor = f.codigo
        JOIN aspirantes a
            ON p.aspirante_id = a.id
        JOIN baremos_16pf b
            ON b.factor_id = f.codigo
           AND b.sexo = a.sexo
           AND b.puntaje_bruto = p.puntaje_total
        JOIN reglas_decatipo_16pf r
            ON r.factor_codigo = f.codigo
      ),
      decatipos_finales AS (
        SELECT 
            c.aspirante_id,
            c.factor,
            c.nombre_factor,
            c.puntaje_total,
            c.decatipo_sin_correccion,
            CASE 
                WHEN c.regla = 'FIJO_8' THEN 8
                WHEN c.regla = 'FIJO_4' THEN 4
                WHEN c.regla = 'SIN_CORRECCION' THEN c.decatipo_sin_correccion
                WHEN c.regla = 'CORRIGE_SI_DM_GT9_-1' 
                     THEN CASE WHEN (SELECT puntaje_total FROM puntajes WHERE factor = 'DM' AND aspirante_id = c.aspirante_id) > 9 
                               THEN c.decatipo_sin_correccion - 1 ELSE c.decatipo_sin_correccion END
                WHEN c.regla = 'CORRIGE_SI_DM_GT9_-2' 
                     THEN CASE WHEN (SELECT puntaje_total FROM puntajes WHERE factor = 'DM' AND aspirante_id = c.aspirante_id) > 9 
                               THEN c.decatipo_sin_correccion - 2 ELSE c.decatipo_sin_correccion END
                WHEN c.regla = 'CORRIGE_SI_DM_GT9_+1' 
                     THEN CASE WHEN (SELECT puntaje_total FROM puntajes WHERE factor = 'DM' AND aspirante_id = c.aspirante_id) > 9 
                               THEN c.decatipo_sin_correccion + 1 ELSE c.decatipo_sin_correccion END
                WHEN c.regla = 'CORRIGE_SI_DM_GT9_+2' 
                     THEN CASE WHEN (SELECT puntaje_total FROM puntajes WHERE factor = 'DM' AND aspirante_id = c.aspirante_id) > 9 
                               THEN c.decatipo_sin_correccion + 2 ELSE c.decatipo_sin_correccion END
                ELSE c.decatipo_sin_correccion
            END AS decatipo_final
        FROM calificados c
      )
      INSERT INTO resultados_16pf (
          aspirante_id, 
          factor, 
          descripcion_factor, 
          puntaje_total, 
          decatipo, 
          porcentaje, 
          nivel, 
          interpretacion
      )
      SELECT 
          d.aspirante_id,
          d.factor,
          d.nombre_factor AS descripcion_factor,
          d.puntaje_total,
          d.decatipo_final,
          ROUND(d.decatipo_final * 0.1, 2) AS porcentaje,
          i.nivel,
          i.descripcion
      FROM decatipos_finales d
      LEFT JOIN interpretaciones_16pf i
          ON i.factor = d.factor
         AND i.nivel = CASE 
                          WHEN d.decatipo_final BETWEEN 1 AND 3 THEN 'Bajo'
                          WHEN d.decatipo_final BETWEEN 4 AND 6 THEN 'Medio'
                          WHEN d.decatipo_final BETWEEN 7 AND 10 THEN 'Alto'
                       END
      ORDER BY d.factor
      RETURNING *;
    `;

    const resultados = (await client.query(resultadosQuery, [aspirante_id]))
      .rows;

    const asp = (
      await client.query(
        `SELECT a.id, a.nombre, a.edad, a.sexo, c.nombre AS cargo
       FROM aspirantes a
       LEFT JOIN cargos c ON a.cargo_aplicado = c.id
       WHERE a.id = $1`,
        [aspirante_id]
      )
    ).rows[0];

    const interpretacionIA = await generarInterpretacionIA(
      { nombre: asp.nombre, edad: asp.edad, sexo: asp.sexo },
      resultados.map((r) => ({
        factor: r.descripcion_factor,
        porcentaje: Number(r.porcentaje),
        interpretacion: r.interpretacion,
      })),
      asp.cargo
    );

    const insertInterpretacion = await client.query(
      `INSERT INTO interpretaciones_ia (aspirante_id, texto_generado, generado_en, fuente_modelo)
       VALUES ($1, $2, NOW(), $3)
       RETURNING id`,
      [aspirante_id, interpretacionIA.texto, interpretacionIA.modelo]
    );

    const interpretacionId = insertInterpretacion.rows[0].id;

    await client.query(
      `INSERT INTO consumos_ia (interpretacion_id, tokens_entrada, tokens_salida)
       VALUES ($1, $2, $3)`,
      [
        interpretacionId,
        interpretacionIA.tokens_entrada,
        interpretacionIA.tokens_salida,
      ]
    );

    await client.query(
      `UPDATE aspirantes 
       SET estado_prueba = 'finalizado' 
       WHERE id = $1`,
      [aspirante_id]
    );

    await client.query("COMMIT");

    const pdfPath = await generarReporte16pf({
      aspirante: {
        id: asp.id,
        nombre: asp.nombre,
        edad: asp.edad,
        sexo: asp.sexo,
      },
      cargo: asp.cargo,
      resultados,
      interpretacionIA: interpretacionIA.texto,
    });

    const pdfUrl = `/reportes/${path.basename(pdfPath)}`;
    await pool.query("UPDATE aspirantes SET reporte_pdf = $1 WHERE id = $2", [
      pdfUrl,
      aspirante_id,
    ]);

    if (enviar_correo === true) {
      const correos = await obtenerCorreosPorAspirante(pool, aspirante_id);
      if (correos.length > 0) {
        envioCorreo = await enviarReporte(correos, pdfPath, {
          nombre: asp.nombre,
        });
      }
    }

    res.json({
      mensaje: "Resultados 16PF calculados e interpretados",
      resultados,
      interpretacionIA,
      pdfUrl,
    });
  } catch (error) {
    await client.query("ROLLBACK");
    logger.error("Error en calificación:", error);
    res.status(500).json({ error: "Error en calificación" });
  } finally {
    client.release();
  }
};

module.exports = { calificarPrueba };
