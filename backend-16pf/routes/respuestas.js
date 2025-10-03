const express = require("express");
const router = express.Router();
const {
  registrarRespuestas,
  obtenerRespuestasPorAspirante,
  guardarRespuesta,
  finalizarPrueba,
} = require("../controllers/respuestasController");

router.post("/", registrarRespuestas);

router.post("/una", guardarRespuesta);

router.get("/:id", obtenerRespuestasPorAspirante);

router.post("/finalizar", finalizarPrueba);

module.exports = router;
