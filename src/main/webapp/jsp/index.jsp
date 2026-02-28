<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REPARTOUT - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-light: #f0f0f0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: white;
            margin: 0;
            padding-top: 80px;
        }

        /* --- NAVIGATION --- */
        .app-bar {
            position: fixed; top: 0; width: 100%; height: 80px;
            background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            display: flex; align-items: center; padding: 0 24px; box-sizing: border-box;
            z-index: 1000; border-bottom: 1px solid #eee;
        }
        .logo { color: var(--pinterest-red); font-weight: 800; font-size: 24px; text-decoration: none; margin-right: 24px; }
        .nav-links { display: flex; gap: 8px; flex-grow: 1; }
        .nav-item { text-decoration: none; color: black; font-weight: 600; padding: 12px 18px; border-radius: 24px; transition: 0.3s; }
        .nav-item:hover { background-color: #efefef; }
        .nav-item.active { background-color: black; color: white; }

        .container { padding: 40px 24px; max-width: 1200px; margin: 0 auto; }

        /* --- DASHBOARD GRID --- */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-top: 30px;
        }

        .card {
            background: var(--bg-light);
            border-radius: 32px;
            padding: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.05); }
        .card.primary { background-color: black; color: white; }
        .card.accent { background-color: #ffedef; color: var(--pinterest-red); }
        .card.info { background-color: #e7f3ff; color: #007bff; }

        .card h3 { margin: 0; font-size: 1.1rem; font-weight: 700; opacity: 0.9; }
        .card .number { font-size: 4rem; font-weight: 800; margin: 15px 0; }
        .card p { margin: 0; font-weight: 600; font-size: 0.9rem; }

        .welcome-text { font-size: 2.5rem; font-weight: 800; margin-bottom: 10px; }
        .role-badge { 
            display: inline-block; 
            background: var(--pinterest-red); 
            color: white; 
            padding: 4px 12px; 
            border-radius: 12px; 
            font-size: 0.75rem; 
            font-weight: 800;
            margin-bottom: 20px;
        }

        /* Quick Actions Bar */
        .quick-actions { display: flex; gap: 15px; margin-top: 30px; }
        .btn-action { 
            background: #eee; 
            color: black; 
            text-decoration: none; 
            padding: 14px 24px; 
            border-radius: 24px; 
            font-weight: 700; 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        }
        .btn-action:hover { background: #e2e2e2; }
    </style>
</head>
<body>

    <nav class="app-bar">
        <a href="${pageContext.request.contextPath}/" class="logo">REPARTOUT</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-item active">Accueil</a>
            
            <sec:authorize access="hasRole('ADMIN')">
                <a href="${pageContext.request.contextPath}/clients" class="nav-item">Clients</a>
                <a href="${pageContext.request.contextPath}/machines" class="nav-item">Machines</a>
            </sec:authorize>
            
            <a href="${pageContext.request.contextPath}/interventions" class="nav-item">
                <sec:authorize access="hasRole('ADMIN')">Interventions</sec:authorize>
                <sec:authorize access="hasRole('TECHNICIEN')">Mes Missions</sec:authorize>
            </a>
        </div>
    </nav>

    <div class="container">
        <span class="role-badge">
            <sec:authorize access="hasRole('ADMIN')">SESSION ADMINISTRATEUR</sec:authorize>
            <sec:authorize access="hasRole('TECHNICIEN')">SESSION TECHNICIEN</sec:authorize>
        </span>
        <h1 class="welcome-text">Bonjour, <sec:authentication property="principal.username" /> </h1>
        <p style="color: #666; font-weight: 600;">Voici un aperçu de l'activité de maintenance.</p>

        <div class="dashboard-grid">
            
            <!-- CARTE COMMUNE : INTERVENTIONS (S'adapte au rôle en coulisses via le contrôleur) -->
            <div class="card primary" onclick="location.href='${pageContext.request.contextPath}/interventions'">
                <h3>
                    <sec:authorize access="hasRole('ADMIN')">Total Interventions</sec:authorize>
                    <sec:authorize access="hasRole('TECHNICIEN')">Mes Interventions</sec:authorize>
                </h3>
                <div class="number">${nbInterventions}</div>
                <p>Accéder au suivi des tickets</p>
            </div>

           <!-- CARTE COMMUNE : MACHINES -->
			<div class="card info" 
			     <sec:authorize access="hasRole('ADMIN')">
			        onclick="location.href='${pageContext.request.contextPath}/machines'" 
			        style="cursor: pointer;"
			     </sec:authorize>
			     <sec:authorize access="hasRole('TECHNICIEN')">
			        style="cursor: default;"
			     </sec:authorize>>
			    
			    <h3>Parc Machines</h3>
			    <div class="number">${nbMachines}</div>
			    <p>État technique du matériel</p>
			</div>

            <!-- CARTE RÉSERVÉE ADMIN : CLIENTS -->
            <sec:authorize access="hasRole('ADMIN')">
                <div class="card accent" onclick="location.href='${pageContext.request.contextPath}/clients'">
                    <h3>Clients Actifs</h3>
                    <div class="number">${nbClients}</div>
                    <p>Gestion du portefeuille client</p>
                </div>
            </sec:authorize>

        </div>

        <div class="quick-actions">
            <sec:authorize access="hasRole('ADMIN')">
                <a href="${pageContext.request.contextPath}/interventions/add" class="btn-action">
                    <i data-lucide="plus-circle"></i> Nouveau Ticket
                </a>
            </sec:authorize>
            <a href="${pageContext.request.contextPath}/interventions" class="btn-action">
                <i data-lucide="list"></i> 
                <sec:authorize access="hasRole('TECHNICIEN')">Voir ma liste de travail</sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">Toutes les interventions</sec:authorize>
            </a>
        </div>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>