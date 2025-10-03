const express = require("express");
const { calificarPrueba } = require("../controllers/calificacionController");
const router = express.Router();

router.post("/calificar", calificarPrueba);

module.exports = router;
