import React, { useEffect, useState } from "react";
import axios from "../api/axiosInstance";
import "../styles/Preguntas.css";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";
import {
  FaArrowAltCircleLeft,
  FaArrowAltCircleRight,
  FaCheckCircle,
  FaSearchPlus,
  FaSearchMinus,
} from "react-icons/fa";

function Preguntas() {
  const [preguntas, setPreguntas] = useState([]);
  const [respuestas, setRespuestas] = useState({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [errorMsg, setErrorMsg] = useState("");
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);

  const [fontSize, setFontSize] = useState(
    parseInt(localStorage.getItem("fontSize")) || 16
  );

  const aspirante = JSON.parse(localStorage.getItem("aspirante"));
  const aspirante_id = aspirante?.id;

  useEffect(() => {
    const fetchPreguntas = async () => {
      try {
        const response = await axios.get("/preguntas");
        setPreguntas(response.data);

        if (aspirante_id) {
          const resResp = await axios.get(`/respuestas/${aspirante_id}`);
          const respuestasGuardadas = {};
          resResp.data.forEach((r) => {
            respuestasGuardadas[r.numero_pregunta] = r.respuesta;
          });
          setRespuestas(respuestasGuardadas);

          if (resResp.data.length > 0) {
            const ultimaRespondida = Math.max(
              ...resResp.data.map((r) => r.numero_pregunta)
            );
            const index = response.data.findIndex(
              (p) => p.numero === ultimaRespondida
            );
            if (index !== -1) {
              setCurrentIndex(index);
            }
          }
        }
      } catch (error) {
        Swal.fire({
          icon: "error",
          title: "Error al cargar preguntas",
          text: "Hubo un problema al cargar las preguntas. Inténtalo de nuevo.",
        });
      }
    };
    fetchPreguntas();
  }, [aspirante_id]);

  const finalizarPrueba = () => {
    Swal.fire({
      title: "¡Gracias por completar la prueba!",
      text: "Tus respuestas han sido registradas con éxito.",
      icon: "success",
      showConfirmButton: false,
      timer: 4000,
      timerProgressBar: true,
      allowOutsideClick: false,
      allowEscapeKey: false,
      didClose: () => {
        localStorage.removeItem("aspiranteToken");
        localStorage.removeItem("aspirante");
        navigate("/");
      },
    });
  };

  const handleChange = async (numero, opcion) => {
    setRespuestas({ ...respuestas, [numero]: opcion });
    setErrorMsg("");

    try {
      await axios.post("/respuestas/una", {
        aspirante_id,
        numero_pregunta: numero,
        respuesta: opcion,
      });
    } catch (error) {
      Swal.fire({
        icon: "error",
        title: "Error al guardar respuesta",
        text: "Hubo un problema al guardar tu respuesta. Inténtalo de nuevo.",
      });
    }
  };

  const handleNext = () => {
    if (!respuestas[preguntas[currentIndex].numero]) {
      setErrorMsg("⚠️ Debes seleccionar una opción antes de continuar.");
      return;
    }
    setErrorMsg("");
    if (currentIndex < preguntas.length - 1) {
      setCurrentIndex(currentIndex + 1);
    }
  };

  const handlePrev = () => {
    setErrorMsg("");
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!respuestas[preguntas[currentIndex].numero]) {
      setErrorMsg("⚠️ Debes seleccionar una opción antes de finalizar.");
      return;
    }

    const confirm = await Swal.fire({
      title: "¿Finalizar prueba?",
      text: "Una vez finalices, ya no podrás cambiar tus respuestas.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Sí, finalizar",
      cancelButtonText: "Cancelar",
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
    });

    if (!confirm.isConfirmed) return;

    try {
      setLoading(true);
      await axios.post("/respuestas/finalizar", {
        aspirante_id: aspirante.id,
      });

      const response = await axios.post("/calificar", {
        aspirante_id: aspirante.id,
        enviar_correo: true,
      });

      Swal.fire("Éxito", "La prueba ha finalizado correctamente", "success");

      finalizarPrueba();
    } catch (error) {
      Swal.fire("Error", "Hubo un problema al finalizar la prueba", "error");
    } finally {
      setLoading(false);
    }
  };

  if (preguntas.length === 0) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando preguntas, por favor espera...</p>
      </div>
    );
  }

  const preguntaActual = preguntas[currentIndex];
  const progreso = Math.round(((currentIndex + 1) / preguntas.length) * 100);

  return (
    <div className="preguntas-wrapper">
      {loading && (
        <div className="overlay">
          <div className="loader"></div>
          <p>Procesando tus resultados, por favor espera...</p>
        </div>
      )}
      <div className="font-controls">
        <button
          onClick={() => {
            const newSize = fontSize - 2 >= 12 ? fontSize - 2 : 12;
            setFontSize(newSize);
            localStorage.setItem("fontSize", newSize);
          }}
        >
          <FaSearchMinus />
        </button>

        <button
          onClick={() => {
            const newSize = fontSize + 2 <= 28 ? fontSize + 2 : 28;
            setFontSize(newSize);
            localStorage.setItem("fontSize", newSize);
          }}
        >
          <FaSearchPlus />
        </button>
      </div>
      <h2 style={{ fontSize: `${fontSize + 12}px` }}>Cuestionario 16PF</h2>

      <div className="progress-bar">
        <div className="progress" style={{ width: `${progreso}%` }}></div>
      </div>
      <p style={{ fontSize: `${fontSize - 4}px` }}>
        Pregunta {currentIndex + 1} de {preguntas.length} ({progreso}%)
      </p>

      <form onSubmit={handleSubmit} className="pregunta-card">
        <div className="pregunta" style={{ fontSize: `${fontSize}px` }}>
          <strong>{preguntaActual.numero}.</strong> {preguntaActual.texto}
          <label>
            <input
              type="radio"
              name={`pregunta-${preguntaActual.numero}`}
              value="A"
              checked={respuestas[preguntaActual.numero] === "A"}
              onChange={() => handleChange(preguntaActual.numero, "A")}
            />
            <span>{preguntaActual.opcion_a}</span>
          </label>
          <label>
            <input
              type="radio"
              name={`pregunta-${preguntaActual.numero}`}
              value="B"
              checked={respuestas[preguntaActual.numero] === "B"}
              onChange={() => handleChange(preguntaActual.numero, "B")}
            />
            <span>{preguntaActual.opcion_b}</span>
          </label>
          <label>
            <input
              type="radio"
              name={`pregunta-${preguntaActual.numero}`}
              value="C"
              checked={respuestas[preguntaActual.numero] === "C"}
              onChange={() => handleChange(preguntaActual.numero, "C")}
            />
            <span>{preguntaActual.opcion_c}</span>
          </label>
          <div className="nav-buttons">
            {currentIndex > 0 && (
              <button
                type="button"
                onClick={handlePrev}
                style={{ fontSize: `${fontSize}px` }}
              >
                <FaArrowAltCircleLeft /> Anterior
              </button>
            )}
            {currentIndex < preguntas.length - 1 && (
              <button
                type="button"
                onClick={handleNext}
                style={{ fontSize: `${fontSize}px` }}
              >
                Siguiente <FaArrowAltCircleRight />
              </button>
            )}
            {currentIndex === preguntas.length - 1 && (
              <button type="submit" style={{ fontSize: `${fontSize}px` }}>
                Finalizar <FaCheckCircle />
              </button>
            )}
          </div>
        </div>

        {errorMsg && <p className="error-msg">{errorMsg}</p>}
      </form>
    </div>
  );
}

export default Preguntas;
