import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "../api/axiosInstance";
import "../styles/Login.css";
import { FaEye, FaEyeSlash } from "react-icons/fa";

function AdminLogin() {
  const [correo, setCorreo] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const res = await axios.post("/admin/login", {
        correo,
        password,
      });

      localStorage.setItem("adminToken", res.data.token);
      localStorage.setItem("usuario_id", res.data.usuario.id);
      localStorage.removeItem("aspiranteToken");

      navigate("/admin/dashboard");
    } catch (err) {
      setError(err.response?.data?.message || "Error en el inicio de sesión");
    }
  };

  return (
    <div className="login-wrapper">
      <div className="login-left">
        <img src="/banneradmin16pf.jpg" alt="Imagen corporativa" />
      </div>

      <div className="login-right">
        <div className="login-card">
          <h1>Login Administrador</h1>
          <form onSubmit={handleSubmit}>
            <input
              type="email"
              placeholder="Correo"
              value={correo}
              onChange={(e) => setCorreo(e.target.value)}
              required
            />
            <div className="password-wrapper">
              <input
                type={showPassword ? "text" : "password"}
                placeholder="Contraseña"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                aria-label="Contraseña"
              />
              <button
                type="button"
                className="toggle-password"
                onClick={() => setShowPassword((s) => !s)}
                aria-label={
                  showPassword ? "Ocultar contraseña" : "Mostrar contraseña"
                }
                title={
                  showPassword ? "Ocultar contraseña" : "Mostrar contraseña"
                }
              >
                {showPassword ? <FaEyeSlash /> : <FaEye />}
              </button>
            </div>
            <button className="submit" type="submit">
              Ingresar
            </button>
          </form>
          {error && <p className="error-message">{error}</p>}
        </div>
      </div>
    </div>
  );
}

export default AdminLogin;
