const db = require("../db");
const logger = require("../utils/logger");

const getDashboardStats = async (req, res) => {
  try {
    const aspirantesEstado = await db.query(
      `SELECT estado_prueba, COUNT(*) AS total
       FROM aspirantes
       GROUP BY estado_prueba`
    );

    const aspirantesNuevos = await db.query(
      `SELECT COUNT(*) AS total
       FROM aspirantes
       WHERE creado_en >= NOW() - INTERVAL '7 days'`
    );

    const totalCargos = await db.query(`SELECT COUNT(*) AS total FROM cargos`);

    const cargoMasPopular = await db.query(
      `SELECT c.nombre, COUNT(a.id) AS total
       FROM cargos c
       LEFT JOIN aspirantes a ON a.cargo_aplicado = c.id
       GROUP BY c.id
       ORDER BY total DESC
       LIMIT 1`
    );

    const totalRequisitos = await db.query(
      `SELECT COUNT(*) AS total FROM requisitos`
    );

    const requisitoMasUsado = await db.query(
      `SELECT r.nombre, COUNT(cr.requisito_id) AS total
       FROM requisitos r
       LEFT JOIN cargo_requisitos cr ON cr.requisito_id = r.id
       GROUP BY r.id
       ORDER BY total DESC
       LIMIT 1`
    );

    res.json({
      aspirantes: {
        en_progreso:
          aspirantesEstado.rows.find((r) => r.estado_prueba === "en_progreso")
            ?.total || 0,
        enviados:
          aspirantesEstado.rows.find((r) => r.estado_prueba === "enviado")
            ?.total || 0,
        finalizados:
          aspirantesEstado.rows.find((r) => r.estado_prueba === "finalizado")
            ?.total || 0,
        nuevos_7_dias: aspirantesNuevos.rows[0].total,
      },
      cargos: {
        total: totalCargos.rows[0].total,
        mas_popular: cargoMasPopular.rows[0] || null,
      },
      requisitos: {
        total: totalRequisitos.rows[0].total,
        mas_usado: requisitoMasUsado.rows[0] || null,
      },
    });
  } catch (err) {
    logger.error("Error al obtener estadísticas", err);
    res.status(500).json({ message: "Error al obtener estadísticas" });
  }
};

module.exports = { getDashboardStats };
