const db = require("../db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const logger = require("../utils/logger");

const login = async (req, res) => {
  const { cedula, password } = req.body;

  try {
    const result = await db.query(
      `SELECT a.id, a.cedula, a.nombre, a.correo, a.edad, a.sexo, a.escolaridad,
          a.cargo_aplicado, a.contrasena, a.estado_prueba, c.nombre AS cargo_nombre
   FROM aspirantes a
   LEFT JOIN cargos c ON a.cargo_aplicado = c.id
   WHERE a.cedula = $1`,
      [cedula]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ message: "Cédula o contraseña inválida" });
    }

    const aspirante = result.rows[0];

    if (aspirante.estado_prueba === "finalizado") {
      return res.status(403).json({
        message: "Ya completaste la prueba, no puedes volver a ingresar",
      });
    }

    const isPasswordValid = await bcrypt.compare(
      password,
      aspirante.contrasena
    );
    if (!isPasswordValid) {
      return res.status(401).json({ message: "Cédula o contraseña inválida" });
    }

    const token = jwt.sign(
      { id: aspirante.id, cedula: aspirante.cedula },
      process.env.JWT_SECRET || "secret_key",
      { expiresIn: "2h" }
    );

    res.json({
      token,
      aspirante: {
        id: aspirante.id,
        cedula: aspirante.cedula,
        nombre: aspirante.nombre,
        correo: aspirante.correo,
        edad: aspirante.edad,
        sexo: aspirante.sexo,
        escolaridad: aspirante.escolaridad,
        cargo_aplicado: aspirante.cargo_aplicado,
        cargo_nombre: aspirante.cargo_nombre,
      },
    });
  } catch (err) {
    logger.error(err);
    res.status(500).json({ message: "Error en el servidor" });
  }
};

module.exports = { login };
