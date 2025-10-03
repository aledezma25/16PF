const express = require("express");
const router = express.Router();
const { getDashboardStats } = require("../controllers/dashboardController");
const verifyAdminToken = require("../middlewares/authMiddleware");

router.get("/stats", verifyAdminToken, getDashboardStats);

module.exports = router;
