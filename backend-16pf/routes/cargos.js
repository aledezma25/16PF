const express = require("express");
const router = express.Router();
const {
  createCargo,
  getCargos,
  getCargosActivos,
  addRequisitoToCargo,
  removeRequisitoFromCargo,
  updateCargo,
  toggleCargoActivo,
  deleteCargo,
} = require("../controllers/cargosController");
const verifyAdminToken = require("../middlewares/authMiddleware");

router.post("/", verifyAdminToken, createCargo);

router.get("/", verifyAdminToken, getCargos);

router.get("/activos", verifyAdminToken, getCargosActivos);

router.post("/add-requisito", verifyAdminToken, addRequisitoToCargo);

router.delete(
  "/:cargoId/requisito/:requisitoId",
  verifyAdminToken,
  removeRequisitoFromCargo
);

router.put("/:id", verifyAdminToken, updateCargo);

router.patch("/:id/activo", verifyAdminToken, toggleCargoActivo);

router.delete("/:id", verifyAdminToken, deleteCargo);

module.exports = router;
