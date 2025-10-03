const db = require("../db");
const logger = require("../utils/logger");

const createRequisito = async (req, res) => {
  const { nombre } = req.body;

  try {
    const result = await db.query(
      "INSERT INTO requisitos (nombre, date) VALUES ($1, NOW()) RETURNING *",
      [nombre]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    logger.error("Error al crear requisito", err);
    res.status(500).json({ message: "Error al crear requisito" });
  }
};

const getRequisitos = async (req, res) => {
  try {
    const result = await db.query(
      "SELECT * FROM requisitos ORDER BY date DESC"
    );
    res.json(result.rows);
  } catch (err) {
    logger.error("Error al obtener requisitos", err);
    res.status(500).json({ message: "Error al obtener requisitos" });
  }
};

const updateRequisito = async (req, res) => {
  const { id } = req.params;
  const { nombre } = req.body;

  try {
    const result = await db.query(
      "UPDATE requisitos SET nombre = $1, date = NOW() WHERE id = $2 RETURNING *",
      [nombre, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Requisito no encontrado" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    logger.error("Error al actualizar requisito", err);
    res.status(500).json({ message: "Error al actualizar requisito" });
  }
};

const deleteRequisito = async (req, res) => {
  const { id } = req.params;

  try {
    await db.query("DELETE FROM cargo_requisitos WHERE requisito_id = $1", [
      id,
    ]);

    const result = await db.query(
      "DELETE FROM requisitos WHERE id = $1 RETURNING *",
      [id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: "Requisito no encontrado" });
    }

    res.json({ message: "Requisito y asociaciones eliminados correctamente" });
  } catch (err) {
    logger.error("Error al eliminar requisito", err);
    res.status(500).json({ message: "Error al eliminar requisito" });
  }
};

module.exports = {
  createRequisito,
  getRequisitos,
  updateRequisito,
  deleteRequisito,
};
