<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty machine.numeroSerie ? 'Ajouter' : 'Modifier'} une Machine - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-soft: #f0f0f0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-soft);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .form-card {
            background: white;
            padding: 40px;
            border-radius: 32px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.06);
            width: 100%;
            max-width: 650px;
            box-sizing: border-box;
        }

        .header-section { margin-bottom: 30px; }
        .logo-small { color: var(--pinterest-red); font-weight: 800; font-size: 1.4rem; text-decoration: none; }
        h2 { font-size: 1.7rem; font-weight: 800; margin: 10px 0; color: #111; }

        .form-group { margin-bottom: 22px; }
        label { display: block; font-weight: 700; font-size: 0.85rem; margin-bottom: 8px; color: #555; }

        input[type="text"], input[type="date"], select, textarea {
            width: 100%;
            padding: 14px 18px;
            border-radius: 16px;
            border: 2px solid #eee;
            background: #fff;
            font-family: inherit;
            font-size: 0.95rem;
            font-weight: 600;
            box-sizing: border-box;
            transition: 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--pinterest-red);
            box-shadow: 0 0 0 4px rgba(230, 0, 35, 0.05);
        }

        input[readonly] { background-color: #f8f8f8; color: #999; cursor: not-allowed; }

        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        @media (max-width: 500px) { .row { grid-template-columns: 1fr; } }

        .actions {
            margin-top: 35px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-submit {
            background: black;
            color: white;
            border: none;
            padding: 16px 32px;
            border-radius: 28px;
            font-weight: 800;
            font-size: 1rem;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background: var(--pinterest-red);
            transform: translateY(-2px);
        }

        .btn-cancel {
            text-decoration: none;
            color: #888;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .btn-cancel:hover { color: #111; }
    </style>
</head>
<body>

    <div class="form-card">
        <div class="header-section">
            <a href="${pageContext.request.contextPath}/" class="logo-small">REPARTOUT</a>
            <h2>${empty machine.numeroSerie ? 'Nouvel Équipement' : 'Détails de la Machine'}</h2>
        </div>

        <form action="${pageContext.request.contextPath}/machines/save" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <div class="row">
                <div class="form-group">
                    <label>Numéro de Série (S/N) *</label>
                    <input type="text" name="numeroSerie" value="${machine.numeroSerie}" 
                           placeholder="Ex: SN-998877"
                           ${not empty machine.numeroSerie ? 'readonly' : ''} required>
                </div>
                <div class="form-group">
                    <label>Propriétaire actuel *</label>
                    <select name="client.numeroClient" required>
                        <option value="">-- Choisir Client --</option>
                        <c:forEach var="c" items="${clients}">
                            <option value="${c.numeroClient}" ${machine.client.numeroClient == c.numeroClient ? 'selected' : ''}>
                                ${c.nomEntreprise}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Marque</label>
                    <input type="text" name="marque" value="${machine.marque}" placeholder="Ex: Caterpillar, HP...">
                </div>
                <div class="form-group">
                    <label>Modèle</label>
                    <input type="text" name="modele" value="${machine.modele}" placeholder="Référence technique">
                </div>
            </div>

            <div class="form-group">
                <label>Description Technique</label>
                <textarea name="description" rows="3" placeholder="Puissance, dimensions, spécificités...">${machine.description}</textarea>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Date de Fabrication</label>
                    <input type="date" name="dateFabrication" value="${machine.dateFabrication}">
                </div>
                <div class="form-group">
                    <label>Échéance Maintenance</label>
                    <input type="date" name="dateFinMaintenance" value="${machine.dateFinMaintenance}">
                </div>
            </div>

            <div class="form-group">
                <label>Notes de suivi (Interne)</label>
                <textarea name="notes" rows="2" placeholder="Remarques particulières...">${machine.notes}</textarea>
            </div>

            <div class="actions">
                <button type="submit" class="btn-submit">
                    ${empty machine.numeroSerie ? 'Enregistrer l\'unité' : 'Mettre à jour'}
                </button>
                <a href="${pageContext.request.contextPath}/machines" class="btn-cancel">Annuler</a>
            </div>
        </form>
    </div>

</body>
</html>