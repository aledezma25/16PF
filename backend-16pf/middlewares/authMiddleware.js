const jwt = require("jsonwebtoken");
const logger = require("../utils/logger");

const verifyAdminToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];

  if (!authHeader) {
    return res.status(401).json({ message: "Token no proporcionado" });
  }

  const token = authHeader.split(" ")[1];

  if (!token) {
    return res.status(401).json({ message: "Token inválido" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET || "secret_key");

    if (decoded.rol !== "admin") {
      return res.status(403).json({ message: "Acceso denegado" });
    }

    req.user = decoded;
    next();
  } catch (err) {
    logger.error("Token no válido o expirado", err);
    res.status(403).json({ message: "Token no válido o expirado" });
  }
};

module.exports = verifyAdminToken;
