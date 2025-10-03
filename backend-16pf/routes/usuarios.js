const express = require("express");
const router = express.Router();
const {
  crearUsuario,
  listarUsuarios,
  editarUsuario,
  cambiarContrasena,
  toggleUsuarioActivo,
  obtenerUsuariosActivos,
} = require("../controllers/usuariosController");
const verifyAdminToken = require("../middlewares/authMiddleware");

router.post("/", verifyAdminToken, crearUsuario);
router.get("/", verifyAdminToken, listarUsuarios);
router.put("/:id", verifyAdminToken, editarUsuario);
router.put("/:id/contrasena", verifyAdminToken, cambiarContrasena);
router.patch("/:id/estado", verifyAdminToken, toggleUsuarioActivo);
router.get("/activos", verifyAdminToken, obtenerUsuariosActivos);

module.exports = router;
