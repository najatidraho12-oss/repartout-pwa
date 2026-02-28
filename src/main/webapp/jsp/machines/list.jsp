<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDate" %>
<c:set var="today" value="<%= LocalDate.now() %>" />
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parc Machines - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-card: #f9f9f9;
            --status-ok: #00ad5d;
            --status-warn: #ffab00;
            --status-crit: #e60023;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: white;
            margin: 0;
            padding-top: 100px;
        }

        /* --- APPBAR PINTEREST --- */
        .app-bar {
            position: fixed; top: 0; width: 100%; height: 80px;
            background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            display: flex; align-items: center; padding: 0 24px; box-sizing: border-box;
            z-index: 1000; border-bottom: 1px solid #eee;
        }
        .logo { color: var(--pinterest-red); font-weight: 800; font-size: 24px; text-decoration: none; margin-right: 24px; }
        .nav-links { display: flex; gap: 8px; flex-grow: 1; }
        .nav-item { text-decoration: none; color: black; font-weight: 600; padding: 12px 18px; border-radius: 24px; }
        .nav-item:hover { background-color: #efefef; }
        .nav-item.active { background-color: black; color: white; }

        .container { padding: 0 24px; max-width: 1300px; margin: 0 auto; }

        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .btn-add { background: var(--pinterest-red); color: white; padding: 12px 24px; border-radius: 24px; text-decoration: none; font-weight: 700; transition: 0.3s; }
        .btn-add:hover { transform: scale(1.05); }

        /* --- GRID DE MACHINES --- */
        .machine-grid {
            column-count: 4; column-gap: 20px;
        }
        @media (max-width: 1200px) { .machine-grid { column-count: 3; } }
        @media (max-width: 900px) { .machine-grid { column-count: 2; } }
        @media (max-width: 600px) { .machine-grid { column-count: 1; } }

        .machine-card {
            break-inside: avoid; background: var(--bg-card); border-radius: 28px;
            padding: 20px; margin-bottom: 20px; transition: 0.3s ease;
            border: 1px solid transparent; cursor: default;
        }
        .machine-card:hover { background: white; border-color: #eee; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }

        .machine-icon {
            font-size: 2rem; margin-bottom: 15px; display: block;
        }

        .serial-tag {
            background: #111; color: white; padding: 4px 12px; border-radius: 10px;
            font-size: 0.7rem; font-weight: 800; margin-bottom: 10px; display: inline-block;
        }

        .machine-card h3 { margin: 0; font-size: 1.1rem; font-weight: 800; }
        .client-name { color: #666; font-size: 0.85rem; margin-top: 5px; }

        /* --- MAINTENANCE BADGE --- */
        .maintenance-info {
            margin-top: 20px; padding: 12px; border-radius: 18px;
            background: white; border: 1px solid #eee; display: flex;
            align-items: center; justify-content: space-between;
        }
        .date-label { font-size: 0.75rem; font-weight: 600; color: #888; }
        .date-value { font-size: 0.85rem; font-weight: 700; }

        .status-dot { width: 10px; height: 10px; border-radius: 50%; }
        .expired { background-color: var(--status-crit); box-shadow: 0 0 8px var(--status-crit); }
        .warning { background-color: var(--status-warn); box-shadow: 0 0 8px var(--status-warn); }
        .ok { background-color: var(--status-ok); box-shadow: 0 0 8px var(--status-ok); }

        .card-actions {
            margin-top: 15px; display: flex; gap: 15px; padding-left: 5px;
        }
        .card-actions a { text-decoration: none; font-size: 0.8rem; font-weight: 700; color: #555; transition: 0.2s; }
        .card-actions a:hover { color: var(--pinterest-red); }
    </style>
</head>
<body>

    <nav class="app-bar">
        <a href="${pageContext.request.contextPath}/" class="logo">REPARTOUT</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-item">Accueil</a>
            <a href="${pageContext.request.contextPath}/clients" class="nav-item">Clients</a>
            <a href="${pageContext.request.contextPath}/machines" class="nav-item active">Machines</a>
            <a href="${pageContext.request.contextPath}/interventions" class="nav-item">Interventions</a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Équipements & Parc</h2>
            <a href="${pageContext.request.contextPath}/machines/add" class="btn-add">+ Ajouter Machine</a>
        </div>

        <div class="machine-grid">
            <c:forEach var="m" items="${machines}">
                <div class="machine-card">
                    <span class="machine-icon">⚙️</span>
                    <span class="serial-tag">SN: ${m.numeroSerie}</span>
                    <h3>${m.marque} ${m.modele}</h3>
                    <p class="client-name">Propriétaire : <strong>${m.client.nomEntreprise}</strong></p>
                    
                    <div class="maintenance-info">
                        <div>
                            <div class="date-label">FIN MAINTENANCE</div>
                            <div class="date-value">${m.dateFinMaintenance}</div>
                        </div>
                        
                        <c:choose>
                            <c:when test="${m.dateFinMaintenance.isBefore(today)}">
                                <div class="status-dot expired" title="Contrat expiré !"></div>
                            </c:when>
                            <c:when test="${m.dateFinMaintenance.isBefore(today.plusDays(30))}">
                                <div class="status-dot warning" title="Expire bientôt"></div>
                            </c:when>
                            <c:otherwise>
                                <div class="status-dot ok" title="Sous contrat"></div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/machines/edit/${m.numeroSerie}">Modifier</a>
                        <a href="${pageContext.request.contextPath}/machines/delete/${m.numeroSerie}" 
                           onclick="return confirm('Supprimer ?');" style="color: #e60023;">Supprimer</a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty machines}">
            <div style="text-align: center; margin-top: 100px; color: #888;">
                <p>Aucun équipement enregistré.</p>
                <a href="${pageContext.request.contextPath}/machines/add" style="color: var(--pinterest-red);">Enregistrer une machine</a>
            </div>
        </c:if>
    </div>

</body>
</html>