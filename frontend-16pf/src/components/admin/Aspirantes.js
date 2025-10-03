import { useEffect, useState } from "react";
import api from "../../api/axiosInstance";
import "../../styles/Requisitos.css";
import { FaEdit, FaPlus, FaBrain, FaEnvelope, FaTrash } from "react-icons/fa";
import { GrUpdate } from "react-icons/gr";
import Modal from "../../utils/Modal";
import Swal from "sweetalert2";
import { toast } from "react-toastify";

function Aspirantes() {
  const [aspirantes, setAspirantes] = useState([]);
  const [busqueda, setBusqueda] = useState("");
  const [formData, setFormData] = useState({
    cedula: "",
    nombre: "",
    correo: "",
    edad: "",
    sexo: "",
    escolaridad: "",
    cargo_aplicado: "",
  });

  const [editando, setEditando] = useState(null);
  const [cargos, setCargos] = useState([]);
  const [cargando, setCargando] = useState(false);
  const [pagina, setPagina] = useState(1);
  const [porPagina] = useState(5);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [filtroEstadoPrueba, setFiltroEstadoPrueba] = useState("todos");
  const [loading, setLoading] = useState(false);
  const [loadingAspirantes, setLoadingAspirantes] = useState(false);
  const [usuariosActivos, setUsuariosActivos] = useState([]);
  const [usuariosSeleccionados, setUsuariosSeleccionados] = useState([]);
  const [usuariosOriginales, setUsuariosOriginales] = useState([]);

  const totalPaginas = Math.ceil(aspirantes.length / porPagina);

  const aspirantesFiltrados = aspirantes.filter(
    (a) =>
      (a.nombre.toLowerCase().includes(busqueda.toLowerCase()) ||
        a.cedula.toString().includes(busqueda)) &&
      (filtroEstadoPrueba === "todos" || a.estado_prueba === filtroEstadoPrueba)
  );

  const aspirantesPaginados = aspirantesFiltrados.slice(
    (pagina - 1) * porPagina,
    pagina * porPagina
  );

  const fetchAspirantes = async () => {
    setLoadingAspirantes(true);
    try {
      const res = await api.get("/aspirantes");
      setAspirantes(res.data);
    } catch (err) {
    } finally {
      setLoadingAspirantes(false);
    }
  };

  const fetchCargos = async () => {
    try {
      const res = await api.get("/cargos/activos");
      setCargos(res.data);
    } catch (err) {}
  };
  const verReporte = async (aspiranteId) => {
    try {
      const { data } = await api.get(`/aspirantes/${aspiranteId}/reporte`);

      if (data.reporte_pdf) {
        const baseURL = process.env.REACT_APP_API_URL.replace("/api", "");
        const url = `${baseURL}${data.reporte_pdf}`;
        window.open(url, "_blank");
      } else {
        toast.info("Este aspirante aún no tiene reporte disponible");
      }
    } catch (error) {
      toast.error("No se pudo obtener el reporte");
    }
  };

  useEffect(() => {
    fetchAspirantes();
    fetchCargos();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setCargando(true);
    try {
      const usuario_id = localStorage.getItem("usuario_id");

      let payload;
      if (editando) {
        const usuariosAgregar = usuariosSeleccionados.filter(
          (id) => !usuariosOriginales.includes(id)
        );
        const usuariosEliminar = usuariosOriginales.filter(
          (id) => !usuariosSeleccionados.includes(id)
        );

        payload = {
          ...formData,
          usuariosAgregar,
          usuariosEliminar,
        };

        await api.put(`/aspirantes/${editando}`, payload);
        Swal.fire("Éxito", "Aspirante editado con éxito", "success");
      } else {
        payload = {
          ...formData,
          usuario_id,
          usuarios_ids: usuariosSeleccionados,
        };

        await api.post("/aspirantes", payload);
        Swal.fire("Éxito", "Aspirante creado con éxito", "success");
      }

      setFormData({
        cedula: "",
        nombre: "",
        correo: "",
        edad: "",
        sexo: "",
        escolaridad: "",
        cargo_aplicado: "",
      });
      setUsuariosSeleccionados([]);
      setUsuariosOriginales([]);
      setEditando(null);
      fetchAspirantes();
      setIsModalOpen(false);
    } catch (error) {
      const mensaje =
        error.response?.data?.error || "Error inesperado al guardar aspirante";
      Swal.fire("Error", mensaje, "error");
    } finally {
      setCargando(false);
    }
  };

  const handleEdit = async (asp) => {
    setFormData({
      cedula: asp.cedula,
      nombre: asp.nombre,
      correo: asp.correo,
      edad: asp.edad,
      sexo: asp.sexo,
      escolaridad: asp.escolaridad,
      cargo_aplicado: asp.cargo_aplicado,
    });
    setEditando(asp.id);
    setIsModalOpen(true);

    try {
      const res = await api.get(`/aspirantes/${asp.id}/usuarios`);
      const asociados = res.data.map((u) => u.id.toString());
      setUsuariosSeleccionados(asociados);
      setUsuariosOriginales(asociados);
    } catch (error) {
      const mensaje =
        error.response?.data?.error || "Error cargando usuarios asociados:";
      Swal.fire("Error", mensaje, "error");
    }
  };

  const handleDelete = async (id) => {
    const confirm = await Swal.fire({
      title: "¿Estás seguro?",
      text: "Esta acción no se puede deshacer",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Sí, eliminar",
      cancelButtonText: "Cancelar",
    });

    if (!confirm.isConfirmed) return;

    try {
      await api.delete(`/aspirantes/${id}`);
      fetchAspirantes();
      Swal.fire("Éxito", "Aspirante eliminado con éxito", "success");
    } catch (err) {
      Swal.fire("Error", "No se pudo eliminar el aspirante", "error");
    }
  };
  const handleRecalificar = async (aspiranteId) => {
    try {
      const confirm = await Swal.fire({
        title: "¿Recalificar prueba?",
        text: "Esto volverá a ejecutar el cálculo de la prueba del aspirante.",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "Sí, recalificar",
        cancelButtonText: "Cancelar",
      });

      if (!confirm.isConfirmed) return;
      setLoading(true);

      await api.post("/calificar", {
        aspirante_id: aspiranteId,
        enviar_correo: true,
      });
      setLoading(false);
      Swal.fire({
        icon: "success",
        title: "Recalificación completada",
        timer: 2000,
        showConfirmButton: false,
      });

      fetchAspirantes();
    } catch (error) {
      Swal.fire({
        icon: "error",
        title: "Error al recalificar",
        text: error.response?.data?.error || "Error desconocido",
      });
    }
  };

  const handleEnviarCorreo = async (id) => {
    const confirm = await Swal.fire({
      title: "¿Enviar correo al aspirante?",
      text: "Se enviará el link de la prueba y las credenciales de inicio de sesión",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Sí, enviar",
      cancelButtonText: "Cancelar",
    });

    if (!confirm.isConfirmed) return;

    try {
      await api.post(`/aspirantes/${id}/enviar-correo`);
      Swal.fire("Éxito", "Correo enviado al aspirante", "success");
      setAspirantes((prev) =>
        prev.map((asp) =>
          asp.id === id ? { ...asp, estado_prueba: "enviado" } : asp
        )
      );
    } catch (err) {
      Swal.fire("Error", "No se pudo enviar el correo", "error");
    }
  };

  useEffect(() => {
    if (isModalOpen) {
      const fetchUsuarios = async () => {
        try {
          const usuarioId = localStorage.getItem("usuario_id");
          const res = await api.get(`/usuarios/activos?excluir=${usuarioId}`);
          setUsuariosActivos(res.data);
        } catch (error) {
          console.error("Error al cargar usuarios activos:", error);
        }
      };
      fetchUsuarios();
    }
  }, [isModalOpen]);

  if (loading) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Realizando calificación, por favor espera...</p>
      </div>
    );
  }
  if (loadingAspirantes) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando aspirantes...</p>
      </div>
    );
  }

  return (
    <div className="requisitos-container">
      <h2 className="requisitos-title">Gestión de Aspirantes</h2>
      <div className="requisitos-header">
        <input
          className="requisitos-input"
          type="text"
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
          placeholder="Buscar aspirante..."
        />
        <select
          className="requisitos-input requisitos-filtro-select"
          value={filtroEstadoPrueba}
          onChange={(e) => setFiltroEstadoPrueba(e.target.value)}
          style={{ marginLeft: 12, marginRight: 12 }}
        >
          <option value="todos">Todos</option>
          <option value="en_progreso">Por enviar</option>
          <option value="enviado">En progreso</option>
          <option value="finalizado">Prueba finalizada</option>
        </select>
        <button
          className="requisitos-btn add"
          onClick={() => {
            setEditando(null);
            setFormData({
              cedula: "",
              nombre: "",
              correo: "",
              edad: "",
              sexo: "",
              escolaridad: "",
              cargo_aplicado: "",
            });
            setIsModalOpen(true);
          }}
        >
          <FaPlus style={{ marginRight: "6px" }} /> Nuevo Aspirante
        </button>
      </div>

      <ul className="requisitos-list">
        {aspirantesPaginados.map((asp) => (
          <li key={asp.id} className="requisito-card">
            <div className="requisito-info">
              <span className="requisito-nombre">
                {asp.nombre} – {asp.cargo_nombre || "Sin cargo"}
              </span>
              <div className="requisito-correo">
                {asp.cedula || "Sin cargo a aplicar"} | {asp.correo} |{" "}
                {asp.edad} edad |{" "}
                {asp.sexo === "M"
                  ? "Masculino"
                  : asp.sexo === "F"
                  ? "Femenino"
                  : "sexo"}{" "}
                | {asp.escolaridad || "escolaridad"}
              </div>
            </div>
            <div className="requisito-actions">
              {Number(asp.total_respuestas) === 187 &&
                asp.estado_prueba === "enviado" && (
                  <GrUpdate
                    className="requisito-icon edit"
                    onClick={() => handleRecalificar(asp.id)}
                    title="Recalificar"
                  />
                )}
              {asp.estado_prueba === "finalizado" && (
                <FaBrain
                  className="requisito-icon view"
                  onClick={() => verReporte(asp.id)}
                  title="Ver reporte PDF"
                />
              )}

              <FaEnvelope
                className={`requisito-icon mail ${
                  asp.estado_prueba === "enviado" ||
                  asp.estado_prueba === "finalizado"
                    ? "enviado"
                    : ""
                }`}
                onClick={() => handleEnviarCorreo(asp.id)}
                title="Enviar correo"
              />

              <FaEdit
                className="requisito-icon edit"
                onClick={() => handleEdit(asp)}
                title="Editar"
              />

              <FaTrash
                className="requisito-icon delete"
                onClick={() => handleDelete(asp.id)}
                title="Eliminar"
              />
            </div>
          </li>
        ))}
      </ul>

      <div className="paginacion">
        <button onClick={() => setPagina(pagina - 1)} disabled={pagina === 1}>
          &lt;
        </button>

        {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
          <div
            key={num}
            className={`numero-pagina ${pagina === num ? "activa" : ""}`}
            onClick={() => setPagina(num)}
          >
            {num}
          </div>
        ))}

        <button
          onClick={() => setPagina(pagina + 1)}
          disabled={pagina === totalPaginas}
        >
          &gt;
        </button>
      </div>

      <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
        <h3>{editando ? "Editar Aspirante" : "Nuevo Aspirante"}</h3>
        <form className="requisitos-form" onSubmit={handleSubmit}>
          <input
            className="requisitos-input"
            type="text"
            value={formData.nombre}
            onChange={(e) =>
              setFormData({ ...formData, nombre: e.target.value })
            }
            placeholder="Nombre completo"
            required
          />
          <input
            className="requisitos-input"
            type="text"
            value={formData.cedula}
            onChange={(e) =>
              setFormData({ ...formData, cedula: e.target.value })
            }
            placeholder="Cédula"
            required
          />
          <input
            className="requisitos-input"
            type="email"
            value={formData.correo}
            onChange={(e) =>
              setFormData({ ...formData, correo: e.target.value })
            }
            placeholder="Correo electrónico"
            required
          />

          <select
            className="requisitos-input"
            value={formData.cargo_aplicado}
            onChange={(e) =>
              setFormData({ ...formData, cargo_aplicado: e.target.value })
            }
            required
          >
            <option value="">Seleccione un cargo</option>
            {cargos.map((c) => (
              <option key={c.id} value={c.id}>
                {c.nombre}
              </option>
            ))}
          </select>
          <label>Seleccione a quien debería llegarle los resultados:</label>

          <div className="requisitos-input">
            <div className="usuarios-chips">
              {usuariosSeleccionados.map((id) => {
                const user = usuariosActivos.find(
                  (u) => u.id.toString() === id
                );
                if (!user) return null;
                return (
                  <div key={id} className="chip">
                    {user.nombre}
                    <span
                      className="chip-close"
                      onClick={() =>
                        setUsuariosSeleccionados(
                          usuariosSeleccionados.filter((uid) => uid !== id)
                        )
                      }
                    >
                      ✕
                    </span>
                  </div>
                );
              })}
            </div>

            <select
              className="requisitos-input"
              onChange={(e) => {
                const value = e.target.value;
                if (value && !usuariosSeleccionados.includes(value)) {
                  setUsuariosSeleccionados([...usuariosSeleccionados, value]);
                }
                e.target.value = "";
              }}
            >
              <option value="">Selecciona un usuario...</option>
              {usuariosActivos
                .filter((u) => !usuariosSeleccionados.includes(u.id.toString()))
                .map((u) => (
                  <option key={u.id} value={u.id}>
                    {u.nombre} ({u.correo})
                  </option>
                ))}
            </select>
          </div>
          <input
            className="requisitos-input"
            type="number"
            value={formData.edad}
            onChange={(e) => setFormData({ ...formData, edad: e.target.value })}
            placeholder="Edad"
          />
          <select
            className="requisitos-input"
            value={formData.sexo}
            onChange={(e) => setFormData({ ...formData, sexo: e.target.value })}
          >
            <option value="">Sexo</option>
            <option value="M">Masculino</option>
            <option value="F">Femenino</option>
          </select>
          <input
            className="requisitos-input"
            type="text"
            value={formData.escolaridad}
            onChange={(e) =>
              setFormData({ ...formData, escolaridad: e.target.value })
            }
            placeholder="Escolaridad"
          />

          <button
            className="requisitos-btn submit"
            type="submit"
            disabled={cargando}
          >
            {cargando
              ? editando
                ? "Actualizando..."
                : "Guardando..."
              : editando
              ? "Actualizar"
              : "Guardar"}
          </button>
        </form>
      </Modal>
    </div>
  );
}

export default Aspirantes;
