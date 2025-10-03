import React from "react";
import { Navigate, useLocation } from "react-router-dom";

function isTokenExpired(token) {
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    const now = Math.floor(Date.now() / 1000);
    return payload.exp < now;
  } catch {
    return true;
  }
}

export const PrivateRoute = ({ children }) => {
  const adminToken = localStorage.getItem("adminToken");
  const aspiranteToken = localStorage.getItem("aspiranteToken");
  const location = useLocation();

  const token = adminToken || aspiranteToken;

  if (!token || isTokenExpired(token)) {
    localStorage.removeItem("adminToken");
    localStorage.removeItem("aspiranteToken");

    if (location.pathname.startsWith("/admin")) {
      return <Navigate to="/admin/login" replace />;
    }
    return <Navigate to="/" replace />;
  }

  return children;
};
