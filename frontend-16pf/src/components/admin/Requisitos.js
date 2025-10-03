import { useEffect, useState } from "react";
import api from "../../api/axiosInstance";
import "../../styles/Requisitos.css";
import { FaEdit, FaTrash, FaPlus } from "react-icons/fa";
import Modal from "../../utils/Modal";
import Swal from "sweetalert2";

function Requisitos() {
  const [requisitos, setRequisitos] = useState([]);
  const [busqueda, setBusqueda] = useState("");
  const [nombre, setNombre] = useState("");
  const [editando, setEditando] = useState(null);
  const [cargando, setCargando] = useState(false);
  const [pagina, setPagina] = useState(1);
  const [porPagina] = useState(5);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [LoadingRequisitos, setLoadingRequisitos] = useState(false);

  const totalPaginas = Math.ceil(requisitos.length / porPagina);

  const requisitosFiltrados = requisitos.filter((req) =>
    req.nombre.toLowerCase().includes(busqueda.toLowerCase())
  );

  const requisitosPaginados = requisitosFiltrados.slice(
    (pagina - 1) * porPagina,
    pagina * porPagina
  );

  const fetchRequisitos = async () => {
    setLoadingRequisitos(true);
    try {
      const res = await api.get("/requisitos");
      setRequisitos(res.data);
    } catch (err) {
    } finally {
      setLoadingRequisitos(false);
    }
  };

  useEffect(() => {
    fetchRequisitos();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setCargando(true);
    try {
      if (editando) {
        await api.put(`/requisitos/${editando}`, { nombre });
        Swal.fire("Éxito", "Requisito actualizado con éxito", "success");
      } else {
        await api.post("/requisitos", { nombre });
        Swal.fire("Éxito", "Requisito creado con éxito", "success");
      }
      setNombre("");
      setEditando(null);
      fetchRequisitos();
      setIsModalOpen(false);
    } catch (err) {
    } finally {
      setCargando(false);
    }
  };

  const handleEdit = (req) => {
    setNombre(req.nombre);
    setEditando(req.id);
    setIsModalOpen(true);
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
      await api.delete(`/requisitos/${id}`);
      fetchRequisitos();
      Swal.fire("Eliminado", "Requisito eliminado con éxito", "success");
    } catch (err) {
      if (err.response && err.response.status === 400) {
        Swal.fire("Error", err.response.data.error, "error");
      } else {
      }
    }
  };
  if (LoadingRequisitos) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando requisitos...</p>
      </div>
    );
  }

  return (
    <div className="requisitos-container">
      <h2 className="requisitos-title">Gestión de Requisitos</h2>
      <div className="requisitos-header">
        <input
          className="requisitos-input"
          type="text"
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
          placeholder="Buscar requisito..."
        />
        <button
          className="requisitos-btn add"
          onClick={() => {
            setEditando(null);
            setNombre("");
            setIsModalOpen(true);
          }}
        >
          <FaPlus style={{ marginRight: "6px" }} /> Nuevo Requisito
        </button>
      </div>

      <ul className="requisitos-list">
        {requisitosPaginados.map((req) => (
          <li key={req.id} className="requisito-card">
            <span className="requisito-nombre">{req.nombre}</span>
            <div className="requisito-actions">
              <FaEdit
                className="requisito-icon edit"
                onClick={() => handleEdit(req)}
                title="Editar"
              />
              <FaTrash
                className="requisito-icon delete"
                onClick={() => handleDelete(req.id)}
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
        <h3>{editando ? "Editar Requisito" : "Nuevo Requisito"}</h3>
        <form className="requisitos-form" onSubmit={handleSubmit}>
          <input
            className="requisitos-input"
            type="text"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            placeholder="Nombre del requisito"
            required
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

export default Requisitos;
