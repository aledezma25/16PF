const express = require("express");
const router = express.Router();
const {
  createRequisito,
  getRequisitos,
  updateRequisito,
  deleteRequisito,
} = require("../controllers/requisitosController");
const verifyAdminToken = require("../middlewares/authMiddleware");

router.post("/", verifyAdminToken, createRequisito);
router.get("/", verifyAdminToken, getRequisitos);
router.put("/:id", verifyAdminToken, updateRequisito);
router.delete("/:id", verifyAdminToken, deleteRequisito);

module.exports = router;
