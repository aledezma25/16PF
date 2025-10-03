const db = require("../db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const logger = require("../utils/logger");

const loginAdmin = async (req, res) => {
  const { correo, password } = req.body;

  try {
    const result = await db.query(
      `SELECT id, nombre, correo, contrasena, rol, activo
       FROM usuarios
       WHERE correo = $1`,
      [correo]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ message: "Correo o contraseña inválidos" });
    }

    const usuario = result.rows[0];

    if (!usuario.activo) {
      return res.status(403).json({ message: "Usuario inactivo" });
    }

    const isMatch = await bcrypt.compare(password, usuario.contrasena);
    if (!isMatch) {
      return res.status(401).json({ message: "Correo o contraseña inválidos" });
    }

    const token = jwt.sign(
      { id: usuario.id, correo: usuario.correo, rol: usuario.rol },
      process.env.JWT_SECRET || "secret_key",
      { expiresIn: "2h" }
    );

    const data = {
      token,
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        correo: usuario.correo,
        rol: usuario.rol,
      },
    };

    res.json(data);
  } catch (err) {
    logger.error(err);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

module.exports = { loginAdmin };
