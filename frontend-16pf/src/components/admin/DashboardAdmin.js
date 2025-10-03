import { Outlet } from "react-router-dom";
import SidebarAdmin from "./SidebarAdmin";
import "../../styles/DashboardAdmin.css";

function DashboardAdmin() {
  return (
    <div className="dashboard-admin">
      <div style={{ display: "flex" }}>
        <SidebarAdmin />

        <div className="dashboard-content">
          <main className="dashboard-main">
            <Outlet />
          </main>
        </div>
      </div>
    </div>
  );
}

export default DashboardAdmin;
