const nodemailer = require("nodemailer");
const logger = require("./logger");

const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: process.env.EMAIL_PORT || 587,
  secure: false,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

const enviarCorreo = async (to, subject, html) => {
  try {
    await transporter.sendMail({
      from: `"Equipo de Selección" <${process.env.EMAIL_USER}>`,
      to,
      subject,
      html,
    });
    logger.info("📧 Correo enviado a:", to);
  } catch (error) {
    logger.error("❌ Error al enviar correo:", error);
    throw new Error("No se pudo enviar el correo");
  }
};

module.exports = enviarCorreo;
