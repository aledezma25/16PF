const pool = require("../db");
const logger = require("../utils/logger");

const obtenerPreguntas = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM preguntas_16pf ORDER BY numero"
    );
    res.json(result.rows);
  } catch (error) {
    logger.error("Error al obtener preguntas:", error);
    res.status(500).json({ mensaje: "Error al obtener preguntas" });
  }
};

module.exports = { obtenerPreguntas };
