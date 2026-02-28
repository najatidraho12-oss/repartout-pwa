<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Clients - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-light: #f0f0f0;
            --card-bg: #ffffff;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: white;
            margin: 0;
            padding-top: 100px;
        }

        /* --- APPBAR STYLE PINTEREST --- */
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

        .container { padding: 0 24px; max-width: 1200px; margin: 0 auto; }

        /* --- HEADER --- */
        .page-header {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;
        }
        .btn-add {
            background-color: var(--pinterest-red); color: white; padding: 12px 24px;
            border-radius: 24px; text-decoration: none; font-weight: 700; transition: 0.3s;
        }
        .btn-add:hover { transform: scale(1.05); }

        /* --- MASONRY GRID --- */
        .client-grid {
            column-count: 4; column-gap: 20px;
        }
        @media (max-width: 1100px) { .client-grid { column-count: 3; } }
        @media (max-width: 800px) { .client-grid { column-count: 2; } }
        @media (max-width: 500px) { .client-grid { column-count: 1; } }

        .client-card {
            break-inside: avoid; background: var(--bg-light); border-radius: 28px;
            padding: 24px; margin-bottom: 20px; transition: 0.3s ease;
            border: 1px solid transparent; position: relative;
        }
        .client-card:hover { background: white; border-color: #eee; box-shadow: 0 12px 24px rgba(0,0,0,0.06); }

        .client-initial {
            width: 45px; height: 45px; background: black; color: white;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: 800; margin-bottom: 15px; font-size: 1.2rem;
        }

        .client-card h3 { margin: 0; font-size: 1.25rem; font-weight: 800; color: #111; }
        .client-info { margin-top: 12px; font-size: 0.9rem; color: #555; }
        .info-row { display: flex; align-items: center; gap: 8px; margin-bottom: 6px; }

        .client-number {
            display: inline-block; background: #ddd; padding: 4px 10px;
            border-radius: 10px; font-size: 0.7rem; font-weight: 800; margin-bottom: 10px;
        }

        .card-actions {
            margin-top: 20px; padding-top: 15px; border-top: 1px solid #ddd;
            display: flex; gap: 15px;
        }
        .card-actions a { text-decoration: none; font-size: 0.85rem; font-weight: 700; color: #111; transition: 0.2s; }
        .card-actions a:hover { color: var(--pinterest-red); }

        .success-msg {
            background: #e6fffa; color: #006644; padding: 15px; border-radius: 20px;
            margin-bottom: 30px; font-weight: 600; border: 1px solid #b2f5ea;
        }
    </style>
</head>
<body>

    <nav class="app-bar">
        <a href="${pageContext.request.contextPath}/" class="logo">REPARTOUT</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-item">Accueil</a>
            <a href="${pageContext.request.contextPath}/clients" class="nav-item active">Clients</a>
            <a href="${pageContext.request.contextPath}/machines" class="nav-item">Machines</a>
            <a href="${pageContext.request.contextPath}/interventions" class="nav-item">Interventions</a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Répertoire Clients</h2>
            <a href="${pageContext.request.contextPath}/clients/add" class="btn-add">+ Ajouter un client</a>
        </div>

        <c:if test="${not empty success}">
            <div class="success-msg">✨ ${success}</div>
        </c:if>

        <div class="client-grid">
            <c:forEach var="client" items="${clients}">
                <div class="client-card">
                    <div class="client-initial">${client.nomEntreprise.substring(0,1).toUpperCase()}</div>
                    <span class="client-number">ID: ${client.numeroClient}</span>
                    <h3>${client.nomEntreprise}</h3>
                    
                    <div class="client-info">
                        <div class="info-row">📧 ${client.email}</div>
                        <div class="info-row">📞 ${client.telephone}</div>
                    </div>

                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/clients/edit/${client.numeroClient}">Modifier</a>
                        <a href="${pageContext.request.contextPath}/clients/delete/${client.numeroClient}" 
                           onclick="return confirm('Supprimer ce client ?');" style="color: var(--pinterest-red);">Supprimer</a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty clients}">
            <div style="text-align: center; padding: 60px; color: #888;">
                <p>Aucun client trouvé.</p>
                <a href="${pageContext.request.contextPath}/clients/add" style="color: var(--pinterest-red); font-weight: bold;">En créer un maintenant</a>
            </div>
        </c:if>

        <footer style="margin-top: 80px; text-align: center; padding-bottom: 40px; color: #bbb; font-size: 0.8rem;">
            &copy; 2025 REPARTOUT - Maintenance Industrielle
        </footer>
    </div>

</body>
</html>