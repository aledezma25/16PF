import { NavLink } from "react-router-dom";
import "../../styles/SidebarAdmin.css";
import { useNavigate } from "react-router-dom";
import Swal from "sweetalert2";

function SidebarAdmin() {
  const navigate = useNavigate();

  const handleLogout = async () => {
    const result = await Swal.fire({
      title: "¿Cerrar sesión?",
      text: "¿Estás seguro que deseas cerrar sesión?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Sí, cerrar sesión",
      cancelButtonText: "Cancelar",
    });

    if (result.isConfirmed) {
      localStorage.removeItem("adminToken");
      navigate("/admin/login");
    }
  };

  return (
    <div className="sidebar-admin">
      <NavLink to="/admin/dashboard" className="admin-panel-title">
        Admin Panel
      </NavLink>
      <nav>
        <ul>
          <li>
            <NavLink to="/admin/dashboard/requisitos">Requisitos</NavLink>
          </li>
          <li>
            <NavLink to="/admin/dashboard/cargos">Cargos</NavLink>
          </li>
          <li>
            <NavLink to="/admin/dashboard/usuarios">Usuarios</NavLink>
          </li>
          <li>
            <NavLink to="/admin/dashboard/aspirantes">Aspirantes</NavLink>
          </li>
          <li className="logout-item">
            <button onClick={handleLogout} className="logout-btn">
              Cerrar sesión
            </button>
          </li>
        </ul>
      </nav>
    </div>
  );
}

export default SidebarAdmin;
