import React, { useState, useEffect } from "react";
import axios from "../api/axiosInstance";
import Modal from "../utils/Modal";
import "../styles/Login.css";
import { useNavigate } from "react-router-dom";
import Swal from "sweetalert2";
import api from "../api/axiosInstance";
import { FaEye, FaEyeSlash } from "react-icons/fa";
import { jwtDecode } from "jwt-decode";

function Login() {
  const [cedula, setCedula] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [aspirante, setAspirante] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem("aspiranteToken");
    if (token && token.trim() !== "") {
      try {
        const { exp } = jwtDecode(token);
        const now = Date.now() / 1000;

        if (exp > now) {
          navigate("/preguntas", { replace: true });
        } else {
          localStorage.removeItem("aspiranteToken");
        }
      } catch (err) {
        localStorage.removeItem("aspiranteToken");
      }
    }
  }, [navigate]);

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post("/login", { cedula, password });

      localStorage.setItem("aspiranteToken", response.data.token);
      localStorage.removeItem("adminToken");
      localStorage.setItem(
        "aspirante",
        JSON.stringify(response.data.aspirante)
      );

      setAspirante(response.data.aspirante);
      setIsModalOpen(true);
    } catch (error) {
      const msg =
        error.response?.data?.message ||
        "Error inesperado. Inténtalo de nuevo más tarde.";

      Swal.fire({
        icon: "error",
        title: "Error de autenticación",
        text: msg,
      });
    }
  };

  const handleConfirm = async () => {
    try {
      const response = await api.put(`/aspirantes/${aspirante.id}`, {
        cedula: aspirante.cedula,
        nombre: aspirante.nombre,
        correo: aspirante.correo,
        edad: aspirante.edad,
        sexo: aspirante.sexo,
        escolaridad: aspirante.escolaridad,
        cargo_aplicado: aspirante.cargo_aplicado,
      });
      Swal.fire({
        icon: "success",
        title: "Datos confirmados y actualizados",
        showConfirmButton: false,
        timer: 2500,
      });
      setAspirante(response.data.aspirante);
      setIsModalOpen(false);
      navigate("/instrucciones");
    } catch (error) {
      Swal.fire({
        icon: "error",
        title: "Error al actualizar datos",
        text: "Hubo un problema al actualizar tus datos. Inténtalo de nuevo.",
      });
    }
  };

  return (
    <div className="login-wrapper">
      <div className="login-left">
        <img src="banner16pf.jpg" alt="Imagen corporativa" />
      </div>

      <div className="login-right">
        <div className="login-card">
          <h1>Prueba 16PF</h1>
          <form onSubmit={handleLogin}>
            <input
              type="text"
              placeholder="Cédula"
              value={cedula}
              onChange={(e) => {
                const value = e.target.value.replace(/\D/g, "");
                setCedula(value);
              }}
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
        </div>
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title="Confirmar datos"
      >
        {aspirante && (
          <form
            onSubmit={(e) => {
              e.preventDefault();
              handleConfirm();
            }}
            className="aspirante-form"
          >
            <p>
              <strong>Cargo al que aspira:</strong> {aspirante.cargo_nombre}
            </p>
            <p>
              <strong>Documento:</strong> {aspirante.cedula}
            </p>

            <label>Nombre:</label>
            <input
              required
              type="text"
              value={aspirante.nombre}
              onChange={(e) =>
                setAspirante({ ...aspirante, nombre: e.target.value })
              }
            />

            <label>Correo:</label>
            <input
              required
              type="email"
              value={aspirante.correo}
              onChange={(e) =>
                setAspirante({ ...aspirante, correo: e.target.value })
              }
            />

            <label>Edad:</label>
            <input
              type="number"
              min="18"
              required
              value={aspirante.edad}
              onChange={(e) =>
                setAspirante({ ...aspirante, edad: e.target.value })
              }
            />

            <label>Sexo:</label>
            <select
              required
              value={aspirante.sexo || ""}
              onChange={(e) =>
                setAspirante({ ...aspirante, sexo: e.target.value })
              }
            >
              <option value="">Seleccione sexo</option>
              <option value="M">Masculino</option>
              <option value="F">Femenino</option>
            </select>

            <label>Escolaridad:</label>
            <select
              required
              value={aspirante.escolaridad || ""}
              onChange={(e) =>
                setAspirante({ ...aspirante, escolaridad: e.target.value })
              }
            >
              <option value="">Seleccione escolaridad</option>
              <option value="Bachiller">Bachiller</option>
              <option value="Técnico">Técnico</option>
              <option value="Tecnólogo">Tecnólogo</option>
              <option value="Profesional">Profesional</option>
              <option value="Postgrado">Posgrado</option>
            </select>

            <div className="modal-actions">
              <button type="submit" className="btn-confirm">
                Confirmar y continuar
              </button>
            </div>
          </form>
        )}
      </Modal>
    </div>
  );
}

export default Login;
