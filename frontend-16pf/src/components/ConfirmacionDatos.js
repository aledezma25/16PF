import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

const ConfirmacionDatos = () => {
  const [aspirante, setAspirante] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const data = localStorage.getItem("aspirante");
    if (data) {
      setAspirante(JSON.parse(data));
    } else {
      navigate("/login");
    }
  }, [navigate]);

  if (!aspirante) return <p>Cargando datos...</p>;

  return (
    <div>
      <h2>Confirmación de Datos</h2>
      <p>
        <strong>Nombre:</strong> {aspirante.nombre}
      </p>
      <p>
        <strong>Cédula:</strong> {aspirante.cedula}
      </p>
      <p>
        <strong>Correo:</strong> {aspirante.correo}
      </p>
      <p>
        <strong>Edad:</strong> {aspirante.edad}
      </p>
      <p>
        <strong>Sexo:</strong> {aspirante.sexo}
      </p>
      <p>
        <strong>Escolaridad:</strong> {aspirante.escolaridad}
      </p>
      <p>
        <strong>Cargo aplicado:</strong> {aspirante.cargo_aplicado}
      </p>

      <button onClick={() => navigate("/siguiente-paso")}>Continuar</button>
    </div>
  );
};

export default ConfirmacionDatos;
