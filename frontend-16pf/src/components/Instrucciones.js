import React from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Instrucciones.css";

function Instrucciones() {
  const navigate = useNavigate();
  const handleStart = () => {
    navigate("/preguntas");
  };

  return (
    <div className="instrucciones-container">
      <h2 className="titulo">INSTRUCCIONES</h2>
      <hr />
      <div className="texto">
        <p>
          A continuación encontrará una serie de cuestiones que permitirán
          conocer sus actitudes e intereses.
        </p>
        <p>
          No existen contestaciones correctas o incorrectas, ya que cada persona
          tiene distintos intereses y puntos de vista. Conteste con sinceridad;
          de esta forma se podrá conocer mejor su forma de ser.
        </p>
        <p>
          Cada cuestión tiene tres posibles respuestas (A, B, C). Lea
          atentamente cada enunciado y seleccione la opción que mejor lo
          represente.
        </p>
        <p>
          Generalmente se contestan cinco o seis preguntas por minuto. La prueba
          completa tomará aproximadamente 30 a 40 minutos.
        </p>
        <p>
          Evite escoger la respuesta “término medio” salvo que realmente no
          pueda decidirse. Procure no dejar ninguna cuestión sin responder.
        </p>
        <p>
          Recuerde que sus respuestas se manejan de forma confidencial y sólo se
          analizan en conjunto, no una por una.
        </p>
        <p className="enfasis">
          Conteste con sinceridad. No intente responder pensando en lo que “es
          bueno” o “impresionaría” al evaluador.
        </p>
      </div>

      <div className="ejemplos">
        <h3>Ejemplos de práctica</h3>
        <ol>
          <li>
            Me gusta presenciar una competición deportiva:
            <br />
            <strong>A.</strong> Sí &nbsp;&nbsp;
            <br />
            <strong>B.</strong> A veces &nbsp;&nbsp;
            <br />
            <strong>C.</strong> No
            <br /> <br />
          </li>
          <li>
            Prefiero las personas:
            <br />
            <strong>A.</strong> Reservadas &nbsp;&nbsp;
            <br />
            <strong>B.</strong> Término medio &nbsp;&nbsp;
            <br />
            <strong>C.</strong> Que hacen amigos fácilmente
            <br />
            <br />
          </li>
          <li>
            “Toro” es a “ternero” como “caballo” es a:
            <br />
            <strong>A.</strong> Potro &nbsp;&nbsp;
            <br />
            <strong>B.</strong> Ternera &nbsp;&nbsp;
            <br />
            <strong>C.</strong> Yegua
          </li>
        </ol>
      </div>

      <button className="btn-iniciar" onClick={handleStart}>
        Comenzar prueba
      </button>
    </div>
  );
}

export default Instrucciones;
