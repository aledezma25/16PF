const pool = require("../db");
const logger = require("../utils/logger");

const registrarRespuestas = async (req, res) => {
  const { aspirante_id, respuestas } = req.body;

  if (!aspirante_id || !Array.isArray(respuestas)) {
    return res.status(400).json({ error: "Datos inválidos" });
  }

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    for (const { numero_pregunta, respuesta } of respuestas) {
      await client.query(
        `INSERT INTO respuestas_16pf (aspirante_id, numero_pregunta, respuesta)
          VALUES ($1, $2, $3)
          ON CONFLICT (aspirante_id, numero_pregunta)
          DO UPDATE SET respuesta = EXCLUDED.respuesta
          `,
        [aspirante_id, numero_pregunta, respuesta]
      );
    }

    await client.query("COMMIT");
    res.status(201).json({ mensaje: "Respuestas registradas exitosamente" });
  } catch (error) {
    await client.query("ROLLBACK");
    logger.error("Error al registrar respuestas:", error);
    res.status(500).json({ error: "Error del servidor" });
  } finally {
    client.release();
  }
};

const obtenerRespuestasPorAspirante = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      "SELECT * FROM respuestas_16pf WHERE aspirante_id = $1 ORDER BY numero_pregunta",
      [id]
    );

    res.json(result.rows);
  } catch (error) {
    logger.error("Error al obtener respuestas:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const guardarRespuesta = async (req, res) => {
  const { aspirante_id, numero_pregunta, respuesta } = req.body;

  if (!aspirante_id || !numero_pregunta || !respuesta) {
    return res.status(400).json({ error: "Datos inválidos" });
  }

  try {
    await pool.query(
      `INSERT INTO respuestas_16pf (aspirante_id, numero_pregunta, respuesta)
       VALUES ($1, $2, $3)
       ON CONFLICT (aspirante_id, numero_pregunta)
       DO UPDATE SET respuesta = EXCLUDED.respuesta`,
      [aspirante_id, numero_pregunta, respuesta]
    );

    res.status(200).json({ mensaje: "Respuesta guardada" });
  } catch (error) {
    logger.error("Error al guardar respuesta:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

const finalizarPrueba = async (req, res) => {
  const { aspirante_id } = req.body;

  try {
    const { rows } = await pool.query(
      "SELECT COUNT(*) AS total FROM respuestas_16pf WHERE aspirante_id = $1",
      [aspirante_id]
    );

    const total = parseInt(rows[0].total, 10);

    if (total < 187) {
      return res.status(400).json({
        error: `El aspirante solo ha respondido ${total}/187 preguntas. No puede finalizar todavía.`,
      });
    }

    await pool.query(
      "UPDATE aspirantes SET estado_prueba = 'finalizado' WHERE id = $1",
      [aspirante_id]
    );

    res.json({ mensaje: "Prueba finalizada exitosamente" });
  } catch (error) {
    logger.error("Error al finalizar prueba:", error);
    res.status(500).json({ error: "Error del servidor" });
  }
};

module.exports = {
  registrarRespuestas,
  obtenerRespuestasPorAspirante,
  guardarRespuesta,
  finalizarPrueba,
};
