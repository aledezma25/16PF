import { useEffect, useState } from "react";
import api from "../../api/axiosInstance";
import "../../styles/Requisitos.css";
import { FaEdit, FaKey, FaPlus } from "react-icons/fa";
import Modal from "../../utils/Modal";
import Swal from "sweetalert2";

function Usuarios() {
  const [usuarios, setUsuarios] = useState([]);
  const [busqueda, setBusqueda] = useState("");
  const [formData, setFormData] = useState({
    nombre: "",
    correo: "",
    contrasena: "",
    rol_id: "",
    activo: true,
  });

  const [editando, setEditando] = useState(null);
  const [cargando, setCargando] = useState(false);
  const [pagina, setPagina] = useState(1);
  const [porPagina] = useState(5);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [loadingUsuarios, setLoadingUsuarios] = useState(false);

  const totalPaginas = Math.ceil(usuarios.length / porPagina);

  const usuariosFiltrados = usuarios.filter((u) =>
    u.nombre.toLowerCase().includes(busqueda.toLowerCase())
  );

  const usuariosPaginados = usuariosFiltrados.slice(
    (pagina - 1) * porPagina,
    pagina * porPagina
  );

  const fetchUsuarios = async () => {
    setLoadingUsuarios(true);
    try {
      const res = await api.get("/usuarios");
      setUsuarios(res.data);
    } catch (err) {
    } finally {
      setLoadingUsuarios(false);
    }
  };

  useEffect(() => {
    fetchUsuarios();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setCargando(true);
    try {
      if (editando) {
        await api.put(`/usuarios/${editando}`, formData);
        Swal.fire("Éxito", "Usuario actualizado", "success");
      } else {
        await api.post("/usuarios", formData);
        Swal.fire("Éxito", "Usuario creado", "success");
      }
      setFormData({
        nombre: "",
        correo: "",
        contrasena: "",
        rol: "",
        activo: true,
      });
      setEditando(null);
      fetchUsuarios();
      setIsModalOpen(false);
    } catch (err) {
      Swal.fire("Error", "No se pudo guardar el usuario", "error");
    } finally {
      setCargando(false);
    }
  };

  const handleEdit = (u) => {
    setFormData({
      nombre: u.nombre,
      correo: u.correo,
      contrasena: "",
      rol: u.rol,
      activo: u.activo,
    });
    setEditando(u.id);
    setIsModalOpen(true);
  };

  const handleChangePassword = (u) => {
    Swal.fire({
      title: `Cambiar contraseña de ${u.nombre}`,
      input: "password",
      inputLabel: "Nueva contraseña",
      inputPlaceholder: "Ingrese la nueva contraseña",
      showCancelButton: true,
      confirmButtonText: "Guardar",
      preConfirm: async (contrasena) => {
        if (!contrasena) {
          Swal.showValidationMessage("La contraseña no puede estar vacía");
          return;
        }
        try {
          await api.put(`/usuarios/${u.id}/contrasena`, { contrasena });
          Swal.fire("Éxito", "Contraseña actualizada", "success");
        } catch (error) {
          Swal.fire("Error", "No se pudo cambiar la contraseña", "error");
        }
      },
    });
  };

  const handleToggleActivo = async (usuario) => {
    try {
      await api.put(`/usuarios/${usuario.id}`, {
        ...usuario,
        activo: !usuario.activo,
      });
      fetchUsuarios();
    } catch (err) {}
  };
  if (loadingUsuarios) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando usuarios...</p>
      </div>
    );
  }

  return (
    <div className="requisitos-container">
      <h2 className="requisitos-title">Gestión de Usuarios</h2>

      <div className="requisitos-header">
        <input
          className="requisitos-input"
          type="text"
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
          placeholder="Buscar usuario..."
        />
        <button
          className="requisitos-btn add"
          onClick={() => {
            setEditando(null);
            setFormData({
              nombre: "",
              correo: "",
              contrasena: "",
              rol: "",
              activo: true,
            });
            setIsModalOpen(true);
          }}
        >
          <FaPlus style={{ marginRight: "6px" }} /> Nuevo Usuario
        </button>
      </div>

      <ul className="requisitos-list">
        {usuariosPaginados.map((u) => (
          <li key={u.id} className="requisito-card">
            <div className="requisito-info">
              <span className="requisito-nombre">
                {u.nombre} – {u.rol || "Sin rol"}
              </span>
              <div className="requisito-correo">{u.correo}</div>
            </div>

            <div className="requisito-actions">
              <div>
                <label className="switch">
                  <input
                    type="checkbox"
                    checked={u.activo}
                    onChange={() => handleToggleActivo(u)}
                  />
                  <span className="slider round"></span>
                  <span
                    style={{
                      color: u.activo ? "green" : "gray",
                      fontWeight: "bold",
                      minWidth: "60px",
                      textAlign: "left",
                      verticalAlign: "middle",
                      fontSize: "0.9rem",
                      marginLeft: "3px",
                      display: "inline-block",
                      lineHeight: "30px",
                    }}
                  >
                    {u.activo ? "Activo" : "Inactivo"}
                  </span>
                </label>
              </div>

              <FaEdit
                className="requisito-icon edit"
                onClick={() => handleEdit(u)}
                title="Editar"
              />
              <FaKey
                className="requisito-icon key"
                onClick={() => handleChangePassword(u)}
                title="Cambiar Contraseña"
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
        <h3>{editando ? "Editar Usuario" : "Nuevo Usuario"}</h3>
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
            type="email"
            value={formData.correo}
            onChange={(e) =>
              setFormData({ ...formData, correo: e.target.value })
            }
            placeholder="Correo electrónico"
            required
          />
          {!editando && (
            <input
              className="requisitos-input"
              type="password"
              value={formData.contrasena}
              onChange={(e) =>
                setFormData({ ...formData, contrasena: e.target.value })
              }
              placeholder="Contraseña"
              required
            />
          )}
          <select
            className="requisitos-input"
            value={formData.rol}
            onChange={(e) => setFormData({ ...formData, rol: e.target.value })}
            required
          >
            <option value="">Seleccione un rol</option>
            <option value="admin">Administrador</option>
            <option value="usuario">Usuario</option>
          </select>

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

export default Usuarios;
