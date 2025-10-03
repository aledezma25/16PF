const fs = require("fs");
const path = require("path");
const nodemailer = require("nodemailer");

function buildTransport() {
  return nodemailer.createTransport({
    host: process.env.EMAIL_HOST,
    port: Number(process.env.EMAIL_PORT || 465),
    secure: String(process.env.EMAIL_SECURE || "true") === "true",
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });
}

/**
 * @param {import('pg').Pool} pool
 */
async function obtenerCorreosUsuariosActivos(pool) {
  const { rows } = await pool.query(
    "SELECT correo FROM usuarios WHERE activo = true AND rol = 'admin' AND correo IS NOT null"
  );
  return rows.map((r) => r.correo);
}

/**
 * @param {import('pg').Pool} pool
 * @param {number} aspiranteId
 */
async function obtenerCorreosPorAspirante(pool, aspiranteId) {
  const { rows } = await pool.query(
    `SELECT u.correo
     FROM usuarios u
     INNER JOIN usuarios_aspirantes ua ON u.id = ua.usuario_id
     WHERE ua.aspirante_id = $1
       AND u.activo = true
       AND u.correo IS NOT NULL`,
    [aspiranteId]
  );
  return rows.map((r) => r.correo);
}

/**
 * @param {string[]} correos
 * @param {string} filePath
 * @param {{ nombre: string }} aspirante
 */
async function enviarReporte(correos, filePath, aspirante) {
  if (!correos.length)
    return { enviado: false, motivo: "No hay usuarios asociados" };

  const transporter = buildTransport();
  const fromName = process.env.EMAIL_FROM_NAME || "Sistema 16PF";

  const bodyImagePath = path.resolve("assets", "body16pf.jpg");

  const htmlBody = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informe de Resultados 16PF</title>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;">
    
    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" border="0" style="max-width: 600px; width: 100%; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    <tr>
                        <td style="padding: 0; text-align: center;">
                            <img src="cid:bodyImage" alt="Encabezado 16PF" style="max-width: 100%; height: auto; display: block;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 30px 20px 10px 20px; text-align: center;">
                            <h1 style="color: #004080; font-size: 28px; margin: 0; font-weight: bold;">INFORME DE RESULTADOS</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 0 20px 30px 20px; text-align: center;">
                            <p style="font-size: 16px; color: #555; line-height: 1.6; margin: 0;">
                                Adjunto a este email encontrarás el informe de resultados
                                del candidato <strong style="color: #004080;">${
                                  aspirante?.nombre || "Aspirante"
                                }</strong>.
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 0 20px;">
                            <hr style="margin: 20px 0; border: none; border-top: 1px solid #ccc;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 20px; text-align: center; background-color: #f8f8f8; border-top: 1px solid #eee;">
                            <p style="font-size: 12px; color: #777; margin: 0;">
                                Este correo fue generado automáticamente, por favor no responder.<br/>
                                <strong style="color: #555;">By Desarrollo & Analítica</strong>
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

  const info = await transporter.sendMail({
    from: `"${fromName}" <${process.env.EMAIL_USER}>`,
    to: correos,
    bcc: process.env.EMAIL_USER,
    subject: `Resultados 16PF - ${aspirante?.nombre || "Aspirante"}`,
    html: htmlBody,
    attachments: [
      { filename: filePath.split("/").pop(), path: filePath },
      {
        filename: "body16pf.jpg",
        path: bodyImagePath,
        cid: "bodyImage",
      },
    ],
  });

  return { enviado: true, messageId: info.messageId };
}

module.exports = {
  obtenerCorreosUsuariosActivos,
  obtenerCorreosPorAspirante,
  enviarReporte,
};
