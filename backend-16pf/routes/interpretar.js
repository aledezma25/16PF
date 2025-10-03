const express = require("express");
const router = express.Router();
const { generarInterpretacionIA } = require("../controllers/interpretacionIA");
const logger = require("../utils/logger");

router.post("/interpretar", async (req, res) => {
  try {
    const { aspirante, resultados, cargo } = req.body;

    if (!aspirante || !resultados || !cargo) {
      return res.status(400).json({ error: "Faltan datos" });
    }

    const interpretacion = await generarInterpretacionIA(
      aspirante,
      resultados,
      cargo
    );

    res.json({ interpretacion });
  } catch (error) {
    logger.error("Error al generar interpretación:", error);
    res.status(500).json({ error: "Error al generar interpretación IA" });
  }
});

module.exports = router;
