<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - REPARTOUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
            --pinterest-red: #e60023;
            --bg-soft: #f0f2f5;
            --text-dark: #111;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-soft);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        /* Arrière-plan décoratif (Cercles flous) */
        .bg-decoration {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }
        .circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.4;
        }
        .circle-1 { width: 400px; height: 400px; background: var(--pinterest-red); top: -100px; right: -100px; }
        .circle-2 { width: 300px; height: 300px; background: #000; bottom: -50px; left: -50px; }

        .login-card {
            background: white;
            padding: 50px 40px;
            border-radius: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 420px;
            text-align: center;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-box {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }
        .logo-icon {
            background: var(--pinterest-red);
            color: white;
            width: 45px;
            height: 45px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .logo-text {
            font-weight: 800;
            font-size: 1.8rem;
            color: var(--text-dark);
            letter-spacing: -1px;
        }

        h2 { font-weight: 800; margin-bottom: 10px; color: #111; font-size: 1.5rem; }
        p.subtitle { color: #777; font-size: 0.9rem; margin-bottom: 35px; font-weight: 500; }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
            position: relative;
        }

        label {
            display: block;
            font-weight: 700;
            font-size: 0.85rem;
            margin-bottom: 8px;
            margin-left: 5px;
            color: #444;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 18px;
            color: #aaa;
        }

        input {
            width: 100%;
            padding: 16px 16px 16px 50px;
            border-radius: 20px;
            border: 2.5px solid #f0f0f0;
            background: #f9f9f9;
            font-family: inherit;
            font-size: 1rem;
            font-weight: 600;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--pinterest-red);
            background: white;
            box-shadow: 0 10px 20px rgba(230, 0, 35, 0.05);
        }

        .btn-login {
            background: var(--text-dark);
            color: white;
            border: none;
            width: 100%;
            padding: 18px;
            border-radius: 22px;
            font-weight: 800;
            font-size: 1.1rem;
            cursor: pointer;
            margin-top: 15px;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login:hover {
            background: var(--pinterest-red);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(230, 0, 35, 0.2);
        }

        .error-msg {
            background: #fee2e2;
            color: #dc2626;
            padding: 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 20px;
            border: 1px solid #fecaca;
        }

        .footer-note {
            margin-top: 30px;
            font-size: 0.8rem;
            color: #999;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="bg-decoration">
        <div class="circle circle-1"></div>
        <div class="circle circle-2"></div>
    </div>

    <div class="login-card">
        <div class="logo-box">
            <div class="logo-icon">
                <i data-lucide="wrench"></i>
            </div>
            <div class="logo-text">REPARTOUT</div>
        </div>

        <h2>Bienvenue</h2>
        <p class="subtitle">Portail de maintenance industrielle</p>

        <!-- Affichage des erreurs de login Spring Security -->
        <c:if test="${not empty param.error}">
            <div class="error-msg">
                <i data-lucide="alert-circle" size="14" style="vertical-align: middle;"></i>
                Identifiants incorrects. Veuillez réessayer.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <!-- Jeton CSRF obligatoire -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label>Nom d'utilisateur</label>
                <div class="input-wrapper">
                    <i data-lucide="user" size="18"></i>
                    <input type="text" name="username" placeholder="ex: admin" required autofocus>
                </div>
            </div>

            <div class="form-group">
                <label>Mot de passe</label>
                <div class="input-wrapper">
                    <i data-lucide="lock" size="18"></i>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <button type="submit" class="btn-login">
                Se connecter
                <i data-lucide="arrow-right" size="20"></i>
            </button>
        </form>

        <div class="footer-note">
            &copy; 2025 REPARTOUT - Système de Gestion SAV
        </div>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>