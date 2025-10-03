const pool = require("../db");
const bcrypt = require("bcrypt");
const logger = require("../utils/logger");

const crearUsuario = async (req, res) => {
  try {
    const { nombre, correo, contrasena, rol } = req.body;

    const existe = await pool.query(
      "SELECT id FROM usuarios WHERE correo = $1",
      [correo]
    );
    if (existe.rows.length > 0) {
      return res.status(400).json({ error: "El correo ya está registrado" });
    }

    const hash = await bcrypt.hash(contrasena, 10);

    const result = await pool.query(
      `INSERT INTO usuarios (nombre, correo, contrasena, rol, creado_en, activo)
       VALUES ($1, $2, $3, $4, NOW(), true)
       RETURNING id, nombre, correo, rol, activo, creado_en`,
      [nombre, correo, hash, rol]
    );

    res
      .status(201)
      .json({ message: "Usuario creado con éxito", usuario: result.rows[0] });
  } catch (error) {
    logger.error("Error creando usuario:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const listarUsuarios = async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT id, nombre, correo, rol, activo, creado_en FROM usuarios ORDER BY id DESC"
    );
    res.json(result.rows);
  } catch (error) {
    logger.error("Error listando usuarios:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const editarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, correo, rol, activo } = req.body;

    const result = await pool.query(
      `UPDATE usuarios 
       SET nombre = $1, correo = $2, rol = $3, activo = $4
       WHERE id = $5
       RETURNING id, nombre, correo, rol, activo, creado_en`,
      [nombre, correo, rol, activo, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    res.json({ message: "Usuario actualizado", usuario: result.rows[0] });
  } catch (error) {
    logger.error("Error editando usuario:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const cambiarContrasena = async (req, res) => {
  try {
    const { id } = req.params;
    const { contrasena } = req.body;

    const hash = await bcrypt.hash(contrasena, 10);

    await pool.query("UPDATE usuarios SET contrasena = $1 WHERE id = $2", [
      hash,
      id,
    ]);

    res.json({ message: "Contraseña actualizada con éxito" });
  } catch (error) {
    logger.error("Error cambiando contraseña:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const toggleUsuarioActivo = async (req, res) => {
  try {
    const { id } = req.params;
    const { activo } = req.body;

    const result = await pool.query(
      "UPDATE usuarios SET activo = $1 WHERE id = $2 RETURNING id, nombre, correo, rol, activo, creado_en",
      [activo, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    res.json({ message: "Usuario actualizado", usuario: result.rows[0] });
  } catch (error) {
    logger.error("Error cambiando estado de usuario:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const obtenerUsuariosActivos = async (req, res) => {
  try {
    const { excluir } = req.query;
    let query = "SELECT id, nombre, correo FROM usuarios WHERE activo = true";
    const values = [];

    if (excluir) {
      query += " AND id <> $1";
      values.push(excluir);
    }

    const result = await pool.query(query, values);
    res.json(result.rows);
  } catch (error) {
    logger.error("Error al obtener usuarios activos:", error);
    res.status(500).json({ error: "Error al obtener usuarios activos" });
  }
};

module.exports = {
  crearUsuario,
  listarUsuarios,
  editarUsuario,
  cambiarContrasena,
  toggleUsuarioActivo,
  obtenerUsuariosActivos,
};
