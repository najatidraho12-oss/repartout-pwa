<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interventions - REPARTOUT</title>
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
            padding-top: 100px;
        }

        /* --- APPBAR --- */
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

        /* --- USER PROFILE SECTION --- */
        .user-section { display: flex; align-items: center; gap: 15px; }
        .user-badge { background: #eee; padding: 8px 16px; border-radius: 20px; font-size: 0.8rem; font-weight: 700; display: flex; align-items: center; gap: 8px; }
        .role-label { background: var(--pinterest-red); color: white; padding: 2px 6px; border-radius: 6px; font-size: 0.65rem; }
        .btn-logout { background: none; border: none; color: var(--pinterest-red); font-weight: 800; cursor: pointer; font-size: 0.85rem; }

        .container { padding: 0 24px; max-width: 1400px; margin: 0 auto; }

        /* --- FILTRES --- */
        .filter-container {
            background: var(--bg-light);
            padding: 20px;
            border-radius: 32px;
            margin-bottom: 40px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }
        .filter-form { display: flex; gap: 10px; flex-grow: 1; align-items: center; }
        .input-search { border: none; padding: 12px 20px; border-radius: 24px; flex-grow: 1; font-family: inherit; font-weight: 600; }
        .select-etat { border: none; padding: 12px 20px; border-radius: 24px; background: white; font-family: inherit; font-weight: 600; cursor: pointer; }
        .btn-search { background: black; color: white; border: none; padding: 12px 24px; border-radius: 24px; font-weight: 700; cursor: pointer; }
        .btn-new { background: var(--pinterest-red); color: white; padding: 12px 24px; border-radius: 24px; text-decoration: none; font-weight: 700; }

        /* --- GRID --- */
        .intervention-grid { column-count: 3; column-gap: 20px; }
        @media (max-width: 1000px) { .intervention-grid { column-count: 2; } }
        @media (max-width: 700px) { .intervention-grid { column-count: 1; } }

        .inter-card { break-inside: avoid; background: white; border: 1px solid #eee; border-radius: 24px; padding: 24px; margin-bottom: 20px; transition: 0.3s; position: relative; }
        .inter-card:hover { transform: translateY(-5px); box-shadow: 0 12px 30px rgba(0,0,0,0.08); }

        .inter-num { font-size: 0.75rem; font-weight: 800; color: #888; margin-bottom: 10px; display: block; }
        .inter-client { font-size: 1.2rem; font-weight: 800; margin-bottom: 5px; color: #111; }
        .inter-machine { color: #666; font-size: 0.9rem; margin-bottom: 15px; }

        .badge { display: inline-block; padding: 6px 14px; border-radius: 14px; font-size: 0.75rem; font-weight: 800; text-transform: uppercase; }
        .status-EN_ATTENTE { background: #eee; color: #555; }
        .status-EN_COURS { background: #e7f3ff; color: #007bff; }
        .status-REALISEE { background: #e6fffa; color: #00ad5d; }
        .status-ANNULEE { background: #ffedef; color: #e60023; }

        .tech-info { margin-top: 20px; display: flex; align-items: center; gap: 10px; font-size: 0.85rem; color: #444; font-weight: 600; }
        .tech-avatar { width: 24px; height: 24px; background: #ddd; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.6rem; }

        .card-footer { margin-top: 20px; padding-top: 15px; border-top: 1px solid #f5f5f5; display: flex; justify-content: space-between; align-items: center; }
        .actions { display: flex; gap: 12px; }
        .actions a { text-decoration: none; font-size: 0.8rem; font-weight: 700; color: #111; }
        .date-box { font-size: 0.75rem; color: #999; font-weight: 600; }
        .btn-trash { color: var(--pinterest-red) !important; }
    </style>
</head>
<body>

    <nav class="app-bar">
        <a href="${pageContext.request.contextPath}/" class="logo">REPARTOUT</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-item">Accueil</a>
            <sec:authorize access="hasRole('ADMIN')">
                <a href="${pageContext.request.contextPath}/clients" class="nav-item">Clients</a>
                <a href="${pageContext.request.contextPath}/machines" class="nav-item">Machines</a>
            </sec:authorize>
            <a href="${pageContext.request.contextPath}/interventions" class="nav-item active">Interventions</a>
        </div>

        <div class="user-section">
            <div class="user-badge">
                <i data-lucide="user" size="16"></i>
                <span><sec:authentication property="principal.username" /></span>
                <span class="role-label">
                    <sec:authorize access="hasRole('ADMIN')">ADMIN</sec:authorize>
                    <sec:authorize access="hasRole('TECHNICIEN')">TECH</sec:authorize>
                </span>
            </div>
            <form action="${pageContext.request.contextPath}/logout" method="post">
                <sec:csrfInput />
                <button type="submit" class="btn-logout">Quitter</button>
            </form>
        </div>
    </nav>

    <div class="container">
        
        <c:if test="${not empty error}">
            <div style="background: #e60023; color: white; padding: 15px; border-radius: 20px; margin-bottom: 20px; font-weight: 600;">
                ⚠️ ${error}
            </div>
        </c:if>

        <div class="filter-container">
            <form action="${pageContext.request.contextPath}/interventions" method="get" class="filter-form">
            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    
			    <!-- CRUCIAL : L'ID technique caché pour permettre l'UPDATE -->
			    <input type="hidden" name="id" value="${intervention.id}">
			    
			  
			            
                <input type="text" name="search" class="input-search" placeholder="Rechercher un client..." value="${searchTerm}">
                
                <select name="etat" class="select-etat">
                    <option value="">Tous les états</option>
                    <c:forEach var="e" items="${etats}">
                        <option value="${e}" ${e == selectedEtat ? 'selected' : ''}>${e.label}</option>
                    </c:forEach>
                </select>
                
                <button type="submit" class="btn-search">Filtrer</button>
                <a href="${pageContext.request.contextPath}/interventions" style="text-decoration: none; color: #888; font-size: 0.8rem; font-weight: 700;">Reset</a>
            </form>
            <sec:authorize access="hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/interventions/add" class="btn-new">+ Nouvelle Intervention</a></sec:authorize>
        </div>

        <div class="intervention-grid">
            <c:forEach var="inter" items="${interventions}">
                <div class="inter-card">
                    <span class="inter-num">TICKET #${inter.id}</span>
                    <div class="inter-client">${inter.machine.client.nomEntreprise}</div>
                    <div class="inter-machine">⚙️ ${inter.machine.marque} - ${inter.machine.numeroSerie}</div>
                    
                    <span class="badge status-${inter.etat}">
                        ${inter.etat.label}
                    </span>

                    <div class="tech-info">
                        <div class="tech-avatar">👤</div>
                        <span>${not empty inter.nomTechnicien ? inter.nomTechnicien : 'Non assigné'}</span>
                    </div>

                    <div class="card-footer">
                        <div class="date-box">📅 ${inter.dateDemande}</div>
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/interventions/print/${inter.id}" title="Imprimer"><i data-lucide="printer" size="18"></i></a>
                            
                            <!-- ACTIONS RÉSERVÉES -->
                            <a href="${pageContext.request.contextPath}/interventions/edit/${inter.id}" title="Modifier"><i data-lucide="edit-3" size="18"></i></a>
                            
                            <sec:authorize access="hasRole('ADMIN')">
                                <a href="${pageContext.request.contextPath}/interventions/delete/${inter.id}" 
                                   class="btn-trash" title="Supprimer" 
                                   onclick="return confirm('Confirmer la suppression ?')">
                                    <i data-lucide="trash-2" size="18"></i>
                                </a>
                            </sec:authorize>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty interventions}">
            <div style="text-align: center; margin-top: 80px;">
                <p style="color: #999; font-size: 1.2rem;">Aucune intervention à afficher.</p>
            </div>
        </c:if>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>