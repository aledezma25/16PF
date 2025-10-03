import { useEffect, useState } from "react";
import api from "../../api/axiosInstance";
import Modal from "../../utils/Modal";
import "../../styles/Cargos.css";
import { FaEdit, FaTrash, FaPlus } from "react-icons/fa";
import Swal from "sweetalert2";

function Cargos() {
  const [cargos, setCargos] = useState([]);
  const [requisitos, setRequisitos] = useState([]);
  const [modalOpen, setModalOpen] = useState(false);
  const [editando, setEditando] = useState(null);
  const [cargando, setCargando] = useState(false);
  const [busqueda, setBusqueda] = useState("");
  const [busquedaReq, setBusquedaReq] = useState("");
  const [requisitosModalOpen, setRequisitosModalOpen] = useState(false);
  const [filtroActivo, setFiltroActivo] = useState("todos");
  const [loadingCargos, setLoadingCargos] = useState(false);
  const [nombre, setNombre] = useState("");
  const [descripcion, setDescripcion] = useState("");
  const [activo, setActivo] = useState(true);
  const [requisitosSeleccionados, setRequisitosSeleccionados] = useState([]);

  const [pagina, setPagina] = useState(1);
  const [porPagina] = useState(5);

  const cargosFiltrados = cargos.filter((cargo) => {
    const coincideNombre = cargo.nombre
      .toLowerCase()
      .includes(busqueda.toLowerCase());
    const coincideEstado =
      filtroActivo === "todos" ||
      (filtroActivo === "activos" && cargo.activo) ||
      (filtroActivo === "inactivos" && !cargo.activo);

    return coincideNombre && coincideEstado;
  });

  const totalPaginas = Math.ceil(cargosFiltrados.length / porPagina);
  const cargosPaginados = cargosFiltrados.slice(
    (pagina - 1) * porPagina,
    pagina * porPagina
  );

  useEffect(() => {
    setPagina(1);
  }, [busqueda]);

  const fetchCargos = async () => {
    setLoadingCargos(true);
    try {
      const res = await api.get("/cargos");
      setCargos(res.data);
    } catch (err) {
    } finally {
      setLoadingCargos(false);
    }
  };

  const fetchRequisitos = async () => {
    try {
      const res = await api.get("/requisitos");
      setRequisitos(res.data);
    } catch (err) {}
  };

  useEffect(() => {
    fetchCargos();
    fetchRequisitos();
  }, []);

  const abrirModal = (cargo = null) => {
    if (cargo) {
      setEditando(cargo.id);
      setNombre(cargo.nombre);
      setDescripcion(cargo.descripcion);
      setActivo(cargo.activo);
      setRequisitosSeleccionados(cargo.requisitos.map((r) => r.id));
    } else {
      setEditando(null);
      setNombre("");
      setDescripcion("");
      setActivo(true);
      setRequisitosSeleccionados([]);
    }
    setModalOpen(true);
  };

  const cerrarModal = () => {
    setModalOpen(false);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setCargando(true);
    try {
      if (editando) {
        await api.put(`/cargos/${editando}`, { nombre, descripcion, activo });
        Swal.fire("Éxito", "Cargo actualizado con éxito", "success");
        const cargoActual = cargos.find((c) => c.id === editando);
        const existentes = cargoActual.requisitos.map((r) => r.id);

        for (const reqId of existentes) {
          if (!requisitosSeleccionados.includes(reqId)) {
            await api.delete(`/cargos/${editando}/requisito/${reqId}`);
            Swal.fire("Éxito", "Requisito eliminado con éxito", "success");
          }
        }

        for (const reqId of requisitosSeleccionados) {
          if (!existentes.includes(reqId)) {
            await api.post("/cargos/add-requisito", {
              cargoId: editando,
              requisitoId: reqId,
            });
            Swal.fire("Éxito", "Requisito agregado con éxito", "success");
          }
        }
      } else {
        await api.post("/cargos", {
          nombre,
          descripcion,
          activo,
          requisitos: requisitosSeleccionados,
        });
      }

      fetchCargos();
      cerrarModal();
    } catch (err) {
    } finally {
      setCargando(false);
    }
  };

  const handleAgregarRequisito = async () => {
    try {
      const { data } = await api.post("/requisitos", { nombre: busquedaReq });

      setRequisitos((prev) => [...prev, data]);
      setRequisitosSeleccionados((prev) => [...prev, data.id]);
      setBusquedaReq("");
    } catch (error) {}
  };

  const handleToggleActivo = async (cargo) => {
    try {
      await api.patch(`/cargos/${cargo.id}/activo`, { activo: !cargo.activo });
      fetchCargos();
    } catch (err) {
      Swal.fire("Error", "Hubo un problema al cambiar de estado", "error");
    }
  };

  const handleEliminarCargo = async (id) => {
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
      await api.delete(`/cargos/${id}`);
      fetchCargos();
      Swal.fire("Éxito", "Cargo eliminado con éxito", "success");
    } catch (err) {
      Swal.fire("Error", "Cargo asociado a un aspirante", "error");
    }
  };

  const toggleRequisito = (id) => {
    if (requisitosSeleccionados.includes(id)) {
      setRequisitosSeleccionados(
        requisitosSeleccionados.filter((r) => r !== id)
      );
    } else {
      setRequisitosSeleccionados([...requisitosSeleccionados, id]);
    }
  };
  if (loadingCargos) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando cargos...</p>
      </div>
    );
  }

  return (
    <div className="requisitos-container">
      <h2 className="requisitos-title">Gestión de Cargos</h2>
      <div className="requisitos-header">
        <input
          className="requisitos-input"
          type="text"
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
          placeholder="Buscar cargo..."
        />
        <select
          className="requisitos-input requisitos-filtro-select"
          value={filtroActivo}
          onChange={(e) => setFiltroActivo(e.target.value)}
        >
          <option value="todos">Todos</option>
          <option value="activos">Activos</option>
          <option value="inactivos">Inactivos</option>
        </select>

        <button className="requisitos-btn add" onClick={() => abrirModal()}>
          <FaPlus style={{ marginRight: "6px" }} />
          Nuevo Cargo
        </button>
      </div>

      <ul className="requisitos-list">
        {cargosPaginados.map((cargo) => (
          <li key={cargo.id} className="requisito-card">
            <div>
              <div
                style={{ display: "flex", alignItems: "center", gap: "10px" }}
              >
                <strong>{cargo.nombre}</strong>
                <div
                  style={{ display: "flex", alignItems: "center", gap: "8px" }}
                >
                  <label className="switch">
                    <input
                      type="checkbox"
                      checked={cargo.activo}
                      onChange={() => handleToggleActivo(cargo)}
                    />
                    <span className="slider round"></span>
                  </label>
                  <span
                    style={{
                      color: cargo.activo ? "green" : "red",
                      fontWeight: "bold",
                      minWidth: "60px",
                      textAlign: "left",
                    }}
                  >
                    {cargo.activo ? "Activo" : "Inactivo"}
                  </span>
                </div>
              </div>
              {cargo.descripcion && (
                <p style={{ margin: "4px 0", color: "#555" }}>
                  {cargo.descripcion}
                </p>
              )}

              {cargo.requisitos.length > 0 && (
                <p style={{ fontStyle: "italic", color: "#88888889" }}>
                  <b>Requisitos:</b>{" "}
                  {cargo.requisitos.map((r) => r.nombre).join(", ")}
                </p>
              )}
            </div>
            <div className="requisito-actions">
              <FaEdit
                className="requisito-icon edit"
                onClick={() => abrirModal(cargo)}
                title="Editar"
              />
              <FaTrash
                className="requisito-icon delete"
                onClick={() => handleEliminarCargo(cargo.id)}
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

      <Modal isOpen={modalOpen} onClose={cerrarModal}>
        <h3>{editando ? "Editar Cargo" : "Nuevo Cargo"}</h3>
        <form className="requisitos-form" onSubmit={handleSubmit}>
          <label>Nombre:</label>
          <input
            className="requisitos-input"
            type="text"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            placeholder="Nombre del cargo"
            required
          />

          <label>Descripción:</label>
          <input
            className="requisitos-input"
            type="text"
            value={descripcion}
            onChange={(e) => setDescripcion(e.target.value)}
            placeholder="Descripción"
          />

          <div className="form-group">
            <button
              type="button"
              className="requisitos-btn-1 submit"
              onClick={() => setRequisitosModalOpen(true)}
              required
            >
              <FaPlus /> Seleccionar Requisitos
            </button>
            {requisitosSeleccionados.length > 0 && (
              <p style={{ marginTop: "8px", fontSize: "0.9rem" }}>
                ✅ {requisitosSeleccionados.length} requisitos seleccionados
              </p>
            )}
            <div className="modal-actions">
              <button
                className="requisitos-btn submit"
                type="submit"
                disabled={cargando}
              >
                {cargando
                  ? editando
                    ? "Actualizando..."
                    : "Agregando..."
                  : editando
                  ? "Actualizar"
                  : "Agregar"}
              </button>
              <button
                className="requisitos-btn cancel"
                type="button"
                onClick={cerrarModal}
              >
                Cancelar
              </button>
            </div>
          </div>
        </form>
      </Modal>
      <Modal
        isOpen={requisitosModalOpen}
        onClose={() => setRequisitosModalOpen(false)}
        large
      >
        <h3>Seleccionar Requisitos</h3>

        <input
          type="text"
          placeholder="Buscar o agregar requisito..."
          className="requisitos-input"
          value={busquedaReq}
          onChange={(e) => setBusquedaReq(e.target.value)}
        />

        {busquedaReq.trim() &&
          !requisitos.some(
            (r) => r.nombre.toLowerCase() === busquedaReq.toLowerCase()
          ) && (
            <div className="nuevo-requisito">
              <button
                className="requisitos-btn add"
                onClick={handleAgregarRequisito}
              >
                <FaPlus /> Agregar "{busquedaReq}"
              </button>
            </div>
          )}

        <div className="requisitos-checklist">
          {requisitos
            .filter((r) =>
              r.nombre.toLowerCase().includes(busquedaReq.toLowerCase())
            )
            .map((req) => (
              <label key={req.id}>
                <input
                  type="checkbox"
                  checked={requisitosSeleccionados.includes(req.id)}
                  onChange={() => toggleRequisito(req.id)}
                />
                {req.nombre}
              </label>
            ))}
        </div>
      </Modal>
    </div>
  );
}

export default Cargos;
