import { useEffect, useState, useCallback } from "react";
import api from "../../api/axiosInstance";
import "../../styles/DashboardHome.css";
import { GrUpdate } from "react-icons/gr";

function DashboardHome() {
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchStats = useCallback(async () => {
    setRefreshing(true);
    try {
      const { data } = await api.get("/admin/dashboard/stats");
      setStats(data);
    } catch (error) {
      console.error("Error al cargar estadísticas:", error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, []);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  if (loading) {
    return (
      <div className="overlay">
        <div className="loader"></div>
        <p>Cargando Estadísticas, por favor espera...</p>
      </div>
    );
  }

  if (!stats) {
    return <p>No se pudieron cargar las estadísticas</p>;
  }

  return (
    <div className="dashboard-container">
      <h1>Estadísticas Generales</h1>

      <button
        className={`refresh-fab ${refreshing ? "spinning" : ""}`}
        onClick={fetchStats}
        disabled={refreshing}
        title="Actualizar estadísticas"
      >
        <GrUpdate />
      </button>

      <div className="stats">
        <div className="stat-card aspirantes">
          <h3>Aspirantes pendientes por iniciar prueba</h3>
          <p>{stats.aspirantes.en_progreso}</p>
        </div>
        <div className="stat-card aspirantes">
          <h3>Aspirantes en progreso</h3>
          <p>{stats.aspirantes.enviados}</p>
        </div>
        <div className="stat-card aspirantes">
          <h3>Aspirantes que ya finalizaron la prueba</h3>
          <p>{stats.aspirantes.finalizados}</p>
        </div>
        <div className="stat-card aspirantes">
          <h3>Aspirantes nuevos en los últimos 7 días</h3>
          <p>{stats.aspirantes.nuevos_7_dias}</p>
        </div>

        <div className="stat-card cargos">
          <h3>Total de cargos registrados</h3>
          <p>{stats.cargos.total}</p>
        </div>
        <div className="stat-card cargos">
          <h3>Cargo más popular</h3>
          <p>{stats.cargos.mas_popular?.nombre || "N/A"}</p>
        </div>

        <div className="stat-card requisitos">
          <h3>Total de requisitos registrados</h3>
          <p>{stats.requisitos.total}</p>
        </div>
        <div className="stat-card requisitos">
          <h3>Requisito más usado</h3>
          <p>{stats.requisitos.mas_usado?.nombre || "N/A"}</p>
        </div>
      </div>
    </div>
  );
}

export default DashboardHome;
