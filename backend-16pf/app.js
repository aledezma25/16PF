const express = require("express");
const cors = require("cors");
const app = express();
const path = require("path");
const logger = require("./utils/logger");

app.use(cors());
app.use(express.json());

const aspirantesRoutes = require("./routes/aspirantes");
app.use("/api/aspirantes", aspirantesRoutes);

app.use("/reportes", express.static(path.join(__dirname, "reportes")));

const respuestasRoutes = require("./routes/respuestas");
app.use("/api/respuestas", respuestasRoutes);

const preguntasRoutes = require("./routes/preguntas");
app.use("/api/preguntas", preguntasRoutes);

const interpretacionRoutes = require("./routes/interpretar");
app.use("/api", interpretacionRoutes);

const calificacionRoutes = require("./routes/calificacion");
app.use("/api", calificacionRoutes);

const authRoutes = require("./routes/auth");
app.use("/api", authRoutes);

const authAdminRoutes = require("./routes/authAdmin");
app.use("/api/admin", authAdminRoutes);

const requisitosRoutes = require("./routes/requisitos");
app.use("/api/requisitos", requisitosRoutes);

const cargosRoutes = require("./routes/cargos");
app.use("/api/cargos", cargosRoutes);

const usuariosRoutes = require("./routes/usuarios");
app.use("/api/usuarios", usuariosRoutes);

const dashboardRoutes = require("./routes/dashboard");
app.use("/api/admin/dashboard", dashboardRoutes);

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  logger.info(`Servidor corriendo en puerto ${PORT}`);
});
