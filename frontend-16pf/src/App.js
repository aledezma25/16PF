import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import Login from "./components/Login";
import Preguntas from "./components/Preguntas";
import Instrucciones from "./components/Instrucciones";
import AdminLogin from "./components/AdminLogin";
import DashboardAdmin from "./components/admin/DashboardAdmin";
import { PrivateRoute } from "./components/PrivateRoute";

import Requisitos from "./components/admin/Requisitos";
import Cargos from "./components/admin/Cargos";
import Usuarios from "./components/admin/Usuarios";
import Aspirantes from "./components/admin/Aspirantes";
import DashboardHome from "./components/admin/DashboardHome";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route
          path="/preguntas"
          element={
            <PrivateRoute>
              <Preguntas />
            </PrivateRoute>
          }
        />
        <Route
          path="/instrucciones"
          element={
            <PrivateRoute>
              <Instrucciones />
            </PrivateRoute>
          }
        />

        <Route path="/admin/login" element={<AdminLogin />} />

        <Route
          path="/admin/dashboard/*"
          element={
            <PrivateRoute>
              <DashboardAdmin />
            </PrivateRoute>
          }
        >
          <Route index element={<DashboardHome />} />
          <Route path="requisitos" element={<Requisitos />} />
          <Route path="cargos" element={<Cargos />} />
          <Route path="usuarios" element={<Usuarios />} />
          <Route path="aspirantes" element={<Aspirantes />} />
        </Route>

        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Router>
  );
}

export default App;
