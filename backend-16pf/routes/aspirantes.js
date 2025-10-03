const express = require("express");
const router = express.Router();
const {
  crearAspirante,
  obtenerAspirante,
  obtenerAspirantes,
  editarAspirante,
  obtenerReportePDF,
  enviarCorreoAspirante,
  eliminarAspirante,
  obtenerUsuariosAspirante,
} = require("../controllers/aspirantesController");
const verifyAdminToken = require("../middlewares/authMiddleware");

router.post("/", verifyAdminToken, crearAspirante);
router.get("/:id", verifyAdminToken, obtenerAspirante);
router.get("/", verifyAdminToken, obtenerAspirantes);
router.put("/:id", editarAspirante);
router.get("/:id/reporte", verifyAdminToken, obtenerReportePDF);
router.post("/:id/enviar-correo", verifyAdminToken, enviarCorreoAspirante);
router.delete("/:id", eliminarAspirante);
router.get("/:id/usuarios", verifyAdminToken, obtenerUsuariosAspirante);

module.exports = router;
