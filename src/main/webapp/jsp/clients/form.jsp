<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty client.numeroClient ? 'Ajouter' : 'Modifier'} Client - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-soft: #f0f0f0;
            --input-bg: #ffffff;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-soft);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* --- FORM CARD --- */
        .form-card {
            background: white;
            padding: 40px;
            border-radius: 32px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 500px;
            box-sizing: border-box;
        }

        .logo-small {
            color: var(--pinterest-red);
            font-weight: 800;
            font-size: 1.5rem;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 30px;
            color: #111;
        }

        /* --- INPUT STYLES --- */
        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 700;
            font-size: 0.85rem;
            margin-bottom: 8px;
            margin-left: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        textarea {
            width: 100%;
            padding: 14px 20px;
            border-radius: 18px;
            border: 2px solid #eee;
            background: var(--input-bg);
            font-family: inherit;
            font-size: 1rem;
            font-weight: 600;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--pinterest-red);
            box-shadow: 0 0 0 4px rgba(230, 0, 35, 0.1);
        }

        /* --- BUTTONS --- */
        .actions {
            margin-top: 35px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-submit {
            background: var(--pinterest-red);
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
            transform: scale(1.03);
            background: #cc001e;
        }

        .btn-cancel {
            text-decoration: none;
            color: #111;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .btn-cancel:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="form-card">
        <a href="${pageContext.request.contextPath}/" class="logo-small">REPARTOUT</a>
        <h2>${empty client.numeroClient ? 'Nouveau Client' : 'Modifier le Client'}</h2>

        <form action="${pageContext.request.contextPath}/clients/save" method="post">
            
            <%-- PROTECTION CSRF : INDISPENSABLE POUR ÉVITER L'ERREUR 403 --%>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <%-- On conserve l'ID en champ caché pour que Spring sache s'il s'agit d'une édition ou d'une création --%>
            <c:if test="${not empty client.numeroClient}">
                <input type="hidden" name="numeroClient" value="${client.numeroClient}">
            </c:if>

            <div class="form-group">
                <label>Nom de l'entreprise</label>
                <input type="text" name="nomEntreprise" value="${client.nomEntreprise}" required placeholder="Nom complet">
            </div>

            <div class="form-group">
                <label>Adresse Postale</label>
                <textarea name="adressePostale" rows="2" placeholder="Siège social...">${client.adressePostale}</textarea>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${client.email}" placeholder="contact@email.com">
                </div>
                <div class="form-group">
                    <label>Téléphone</label>
                    <input type="tel" name="telephone" value="${client.telephone}" placeholder="+212...">
                </div>
            </div>

            <div class="form-group">
                <label>Notes internes</label>
                <textarea name="notes" rows="2" placeholder="Informations importantes...">${client.notes}</textarea>
            </div>

            <div class="actions">
                <button type="submit" class="btn-submit">
                    ${empty client.numeroClient ? 'Créer le client' : 'Sauvegarder'}
                </button>
                <a href="${pageContext.request.contextPath}/clients" class="btn-cancel">Annuler</a>
            </div>
        </form>
    </div>

</body>
</html>