const db = require("../db");
const logger = require("../utils/logger");

const createCargo = async (req, res) => {
  const { nombre, descripcion, activo = true, requisitos } = req.body;

  try {
    await db.query("BEGIN");

    const resultCargo = await db.query(
      "INSERT INTO cargos (nombre, descripcion, activo) VALUES ($1, $2, $3) RETURNING *",
      [nombre, descripcion, activo]
    );

    const cargo = resultCargo.rows[0];

    if (requisitos && requisitos.length > 0) {
      for (const requisitoId of requisitos) {
        await db.query(
          "INSERT INTO cargo_requisitos (cargo_id, requisito_id) VALUES ($1, $2)",
          [cargo.id, requisitoId]
        );
      }
    }

    await db.query("COMMIT");

    res.status(201).json({
      ...cargo,
      requisitos: requisitos || [],
    });
  } catch (err) {
    await db.query("ROLLBACK");
    logger.error("Error al crear cargo", err);
    res.status(500).json({ message: "Error al crear cargo" });
  }
};

const getCargos = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT c.id AS cargo_id, c.nombre AS cargo_nombre, c.descripcion, c.activo,
             r.id AS requisito_id, r.nombre AS requisito_nombre
      FROM cargos c
      LEFT JOIN cargo_requisitos cr ON c.id = cr.cargo_id
      LEFT JOIN requisitos r ON cr.requisito_id = r.id
      ORDER BY c.id DESC, r.id ASC
    `);

    const cargosMap = new Map();

    result.rows.forEach((row) => {
      if (!cargosMap.has(row.cargo_id)) {
        cargosMap.set(row.cargo_id, {
          id: row.cargo_id,
          nombre: row.cargo_nombre,
          descripcion: row.descripcion,
          activo: row.activo,
          requisitos: [],
        });
      }

      if (row.requisito_id) {
        cargosMap.get(row.cargo_id).requisitos.push({
          id: row.requisito_id,
          nombre: row.requisito_nombre,
        });
      }
    });

    res.json(Array.from(cargosMap.values()));
  } catch (err) {
    logger.error("Error al obtener cargos", err);
    res.status(500).json({ message: "Error al obtener cargos" });
  }
};

const getCargosActivos = async (req, res) => {
  try {
    const result = await db.query(`
      SELECT c.id AS cargo_id, c.nombre AS cargo_nombre, c.descripcion, c.activo,
             r.id AS requisito_id, r.nombre AS requisito_nombre
      FROM cargos c
      LEFT JOIN cargo_requisitos cr ON c.id = cr.cargo_id
      LEFT JOIN requisitos r ON cr.requisito_id = r.id
      WHERE c.activo = true
      ORDER BY c.id DESC, r.id ASC
    `);

    const cargosMap = new Map();

    result.rows.forEach((row) => {
      if (!cargosMap.has(row.cargo_id)) {
        cargosMap.set(row.cargo_id, {
          id: row.cargo_id,
          nombre: row.cargo_nombre,
          descripcion: row.descripcion,
          activo: row.activo,
          requisitos: [],
        });
      }

      if (row.requisito_id) {
        cargosMap.get(row.cargo_id).requisitos.push({
          id: row.requisito_id,
          nombre: row.requisito_nombre,
        });
      }
    });

    res.json(Array.from(cargosMap.values()));
  } catch (err) {
    logger.error("Error al obtener cargos activos", err);
    res.status(500).json({ message: "Error al obtener cargos activos" });
  }
};

const removeRequisitoFromCargo = async (req, res) => {
  const { cargoId, requisitoId } = req.params;

  try {
    const result = await db.query(
      "DELETE FROM cargo_requisitos WHERE cargo_id = $1 AND requisito_id = $2 RETURNING *",
      [cargoId, requisitoId]
    );

    if (result.rowCount === 0) {
      return res
        .status(404)
        .json({ message: "No existe esa relación cargo-requisito" });
    }

    res.json({ message: "Requisito eliminado del cargo correctamente" });
  } catch (err) {
    logger.error("Error al eliminar requisito del cargo", err);
    res.status(500).json({ message: "Error al eliminar requisito del cargo" });
  }
};

const updateCargo = async (req, res) => {
  const { id } = req.params;
  const { nombre, descripcion, activo } = req.body;

  try {
    const result = await db.query(
      "UPDATE cargos SET nombre = $1, descripcion = $2, activo = $3 WHERE id = $4 RETURNING *",
      [nombre, descripcion, activo, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: "Cargo no encontrado" });
    }

    res.json(result.rows[0]);
  } catch (err) {
    logger.error("Error al actualizar cargo", err);
    res.status(500).json({ message: "Error al actualizar cargo" });
  }
};

const toggleCargoActivo = async (req, res) => {
  const { id } = req.params;
  const { activo } = req.body;

  try {
    const result = await db.query(
      "UPDATE cargos SET activo = $1 WHERE id = $2 RETURNING *",
      [activo, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: "Cargo no encontrado" });
    }

    res.json({
      message: activo
        ? "Cargo activado correctamente"
        : "Cargo inactivado correctamente",
      cargo: result.rows[0],
    });
  } catch (err) {
    logger.error("Error al cambiar estado del cargo", err);
    res.status(500).json({ message: "Error al cambiar estado del cargo" });
  }
};

const addRequisitoToCargo = async (req, res) => {
  const { cargoId, requisitoId } = req.body;

  try {
    const result = await db.query(
      "INSERT INTO cargo_requisitos (cargo_id, requisito_id) VALUES ($1, $2) RETURNING *",
      [cargoId, requisitoId]
    );

    res.status(201).json({
      message: "Requisito agregado al cargo correctamente",
      relacion: result.rows[0],
    });
  } catch (err) {
    if (err.code === "23505") {
      return res
        .status(400)
        .json({ message: "Este requisito ya está asociado al cargo" });
    }
    logger.error("Error al agregar requisito al cargo", err);
    res.status(500).json({ message: "Error al agregar requisito al cargo" });
  }
};

const deleteCargo = async (req, res) => {
  const { id } = req.params;

  try {
    await db.query("BEGIN");

    await db.query("DELETE FROM cargo_requisitos WHERE cargo_id = $1", [id]);

    const result = await db.query(
      "DELETE FROM cargos WHERE id = $1 RETURNING *",
      [id]
    );

    if (result.rowCount === 0) {
      await db.query("ROLLBACK");
      return res.status(404).json({ message: "Cargo no encontrado" });
    }

    await db.query("COMMIT");

    res.json({
      message: "Cargo eliminado correctamente",
      cargo: result.rows[0],
    });
  } catch (err) {
    await db.query("ROLLBACK");
    logger.error("Error al eliminar cargo", err);
    res.status(500).json({ message: "Error al eliminar cargo" });
  }
};

module.exports = {
  createCargo,
  getCargos,
  removeRequisitoFromCargo,
  updateCargo,
  addRequisitoToCargo,
  toggleCargoActivo,
  getCargosActivos,
  deleteCargo,
};
