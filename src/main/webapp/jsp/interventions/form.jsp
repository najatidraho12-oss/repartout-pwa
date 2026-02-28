<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intervention - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root { --pinterest-red: #e60023; --bg-soft: #f4f4f4; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-soft); margin: 0; padding: 40px 20px; display: flex; justify-content: center; }
        .form-card { background: white; padding: 40px; border-radius: 32px; box-shadow: 0 15px 50px rgba(0,0,0,0.08); width: 100%; max-width: 700px; }
        .header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 30px; }
        .role-tag { background: #111; color: white; padding: 5px 12px; border-radius: 10px; font-size: 0.7rem; font-weight: 800; text-transform: uppercase; }
        h2 { font-size: 1.6rem; font-weight: 800; margin: 5px 0; color: #111; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: 700; font-size: 0.85rem; margin-bottom: 8px; color: #555; }
        input, select, textarea { 
            width: 100%; padding: 14px 18px; border-radius: 16px; border: 2px solid #eee; 
            font-family: inherit; font-size: 0.95rem; font-weight: 600; box-sizing: border-box; 
            transition: 0.3s;
        }
        input:focus, select:focus, textarea:focus { outline: none; border-color: var(--pinterest-red); }
        input[readonly], select[disabled], textarea[readonly], .locked-field { 
            background-color: #f9f9f9; color: #888; cursor: not-allowed; border-style: dashed;
        }
        .section-title { font-size: 0.9rem; font-weight: 800; color: var(--pinterest-red); margin: 30px 0 15px 0; text-transform: uppercase; border-bottom: 2px solid #f0f0f0; padding-bottom: 5px; }
        .btn-submit { background: black; color: white; border: none; padding: 16px 32px; border-radius: 28px; font-weight: 800; cursor: pointer; width: 100%; margin-top: 20px; }
        .btn-submit:hover { background: var(--pinterest-red); }
        .btn-back { color: var(--pinterest-red); font-weight: 800; text-decoration: none; display: flex; align-items: center; gap: 5px; margin-bottom: 10px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    </style>
</head>
<body>
    <div class="form-card">
        <div class="header">
            <div>
                <a href="${pageContext.request.contextPath}/interventions" class="btn-back">
                    <i data-lucide="arrow-left" size="16"></i> Retour
                </a>
                <h2>
                    <c:choose>
                        <c:when test="${empty intervention.id}">Nouvelle Demande</c:when>
                        <c:otherwise>Intervention #${intervention.id}</c:otherwise>
                    </c:choose>
                </h2>
            </div>
            <%-- CORRECTION : sec:authorize doit être en dehors de toute balise c:choose --%>
            <div class="role-tags">
                <sec:authorize access="hasRole('ADMIN')"><span class="role-tag">ADMINISTRATEUR</span></sec:authorize>
                <sec:authorize access="hasRole('TECHNICIEN')"><span class="role-tag">TECHNICIEN</span></sec:authorize>
            </div>
        </div>
		<c:if test="${not empty error}">
		    <div style="background-color: #fff5f5; border: 2px solid var(--pinterest-red); color: var(--pinterest-red); padding: 20px; border-radius: 16px; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;">
		        <i data-lucide="alert-triangle"></i>
		        <span style="font-weight: 800; font-size: 0.95rem;">${error}</span>
		    </div>
		</c:if>

        <form action="${pageContext.request.contextPath}/interventions/save" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${intervention.id}">

            <div class="section-title">Informations Générales</div>
            
            <div class="form-group">
                <label>Machine concernée (Numéro de Série) *</label>
                
                <%-- CORRECTION : On utilise sec:authorize individuellement --%>
                <sec:authorize access="hasRole('TECHNICIEN')">
                    <input type="text" value="${intervention.machine.marque} ${intervention.machine.modele} (${intervention.machine.numeroSerie})" readonly class="locked-field">
                    <input type="hidden" name="machine.numeroSerie" value="${intervention.machine.numeroSerie}">
                </sec:authorize>
                
                <sec:authorize access="hasRole('ADMIN')">
                    <select name="machine.numeroSerie" required>
                        <option value="">-- Sélectionner l'équipement --</option>
                        <c:forEach var="m" items="${machines}">
                            <option value="${m.numeroSerie}" ${intervention.machine.numeroSerie == m.numeroSerie ? 'selected' : ''}>
                                ${m.numeroSerie} - ${m.marque} ${m.modele} (Client: ${m.client.nomEntreprise})
                            </option>
                        </c:forEach>
                    </select>
                </sec:authorize>
            </div>

            <div class="form-group">
                <label>Description du problème</label>
                <textarea name="descriptionProbleme" rows="3" 
                    <sec:authorize access="hasRole('TECHNICIEN')">readonly</sec:authorize>
                    placeholder="Détaillez le problème...">${intervention.descriptionProbleme}</textarea>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Date prévue</label>
                    <input type="date" name="dateInterventionPrevisionnelle" value="${intervention.dateInterventionPrevisionnelle}"
                        <sec:authorize access="hasRole('TECHNICIEN')">readonly</sec:authorize>>
                </div>
                <div class="form-group">
                    <label>Technicien Assigné</label>
                    <input type="text" name="nomTechnicien" value="${intervention.nomTechnicien}" 
                           <sec:authorize access="hasRole('TECHNICIEN')">readonly</sec:authorize> 
                           placeholder="Nom du technicien">
                </div>
            </div>

            <div class="section-title">État & Rapport d'exécution</div>
            
            <div class="form-group">
                <label>Statut actuel</label>
                <select name="etat">
                    <option value="EN_ATTENTE" ${intervention.etat == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                    <option value="EN_COURS" ${intervention.etat == 'EN_COURS' ? 'selected' : ''}>En cours</option>
                    <option value="REALISEE" ${intervention.etat == 'REALISEE' ? 'selected' : ''}>Réalisée</option>
                    <option value="ANNULEE" ${intervention.etat == 'ANNULEE' ? 'selected' : ''}>Annulée</option>
                </select>
            </div>

            <div class="form-group">
                <label>Compte-rendu technique (Notes)</label>
                <textarea name="notes" rows="6" placeholder="Actions effectuées...">${intervention.notes}</textarea>
            </div>

            <button type="submit" class="btn-submit">
                <c:choose>
                    <c:when test="${empty intervention.id}">Créer l'intervention</c:when>
                    <c:otherwise>Enregistrer les modifications</c:otherwise>
                </c:choose>
            </button>
        </form>
    </div>
    <script>lucide.createIcons();</script>
</body>
</html>