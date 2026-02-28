<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Bon d'Intervention - ${inter.id}</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 40px; color: #1a1a1a; line-height: 1.6; }
        .no-print { 
            background: #f4f4f4; padding: 15px; border-radius: 8px; margin-bottom: 30px; 
            display: flex; gap: 10px; border: 1px solid #ddd;
        }
        button { 
            padding: 10px 20px; cursor: pointer; border-radius: 5px; border: none;
            font-weight: bold; transition: 0.2s;
        }
        .btn-print { background: #e60023; color: white; }
        .btn-close { background: #333; color: white; }
        
        .header { display: flex; justify-content: space-between; border-bottom: 3px solid #e60023; padding-bottom: 20px; }
        .logo-area h1 { margin: 0; color: #e60023; font-size: 2.2rem; letter-spacing: -1px; }
        
        .section { margin-top: 30px; }
        .section-title { 
            font-weight: 800; background: #1a1a1a; color: white; 
            padding: 8px 15px; text-transform: uppercase; font-size: 0.9rem;
            border-radius: 4px;
        }
        
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; margin-top: 15px; }
        .info-block p { margin: 5px 0; font-size: 0.95rem; }
        .info-block strong { color: #555; display: inline-block; width: 120px; }
        
        .content-box { 
            border: 1px solid #eee; background: #fafafa; padding: 15px; 
            border-radius: 8px; min-height: 80px; margin-top: 10px; white-space: pre-wrap;
        }

        .footer-sig { margin-top: 60px; display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
        .sig-box { border: 2px dashed #ccc; height: 120px; border-radius: 8px; margin-top: 10px; }
        .sig-label { font-weight: bold; font-size: 0.85rem; text-align: center; color: #888; margin-top: 40px; }

        @media print { 
            .no-print { display: none; }
            body { padding: 0; }
            .content-box { border: 1px solid #ddd; background: white; }
        }
    </style>
</head>
<body>

    <div class="no-print">
        <button onclick="window.print()" class="btn-print">Imprimer le document</button>
        <button onclick="window.history.back()" class="btn-close">Retour</button>
    </div>

    <div class="header">
        <div class="logo-area">
            <h1>REPARTOUT</h1>
            <p><strong>Expertise Maintenance Industrielle</strong><br>SAV & Diagnostic Technique</p>
        </div>
        <div style="text-align: right;">
            <h2 style="margin:0; color: #444;">BON D'INTERVENTION</h2>
            <p style="font-size: 1.2rem; font-weight: bold; margin: 5px 0;">N° ${inter.id}</p>
            <p>Émis le : ${inter.dateDemande}</p>
        </div>
    </div>

    <div class="section">
        <div class="section-title">Identification Client & Matériel</div>
        <div class="info-grid">
            <div class="info-block">
                <p><strong>Client :</strong> ${inter.machine.client.nomEntreprise}</p>
                <p><strong>Email :</strong> ${inter.machine.client.email}</p>
                <p><strong>Téléphone :</strong> ${inter.machine.client.telephone}</p>
            </div>
            <div class="info-block">
                <p><strong>Machine :</strong> ${inter.machine.marque} ${inter.machine.modele}</p>
                <p><strong>N° Série :</strong> ${inter.machine.numeroSerie}</p>
                <p><strong>Localisation :</strong> ${inter.machine.client.adressePostale}</p>
            </div>
        </div>
    </div>

    <div class="section">
        <div class="section-title">Rapport de Maintenance</div>
        <div class="info-grid" style="grid-template-columns: 1fr 1fr; margin-bottom: 20px;">
            <p><strong>Technicien :</strong> ${not empty inter.nomTechnicien ? inter.nomTechnicien : 'Non assigné'}</p>
            <p><strong>Statut Final :</strong> ${inter.etat}</p>
        </div>
        
        <p><strong>Description de la panne / Symptômes :</strong></p>
        <div class="content-box">${inter.descriptionProbleme}</div>

        <p style="margin-top: 20px;"><strong>Travaux effectués / Notes techniques :</strong></p>
        <div class="content-box">${not empty inter.notes ? inter.notes : 'Aucune note renseignée.'}</div>
    </div>

    <div class="footer-sig">
        <div>
            <p><strong>Cachet et Signature Technicien</strong></p>
            <div class="sig-box"></div>
        </div>
        <div>
            <p><strong>Bon pour accord Client</strong></p>
            <div class="sig-box">
                <div class="sig-label">Mention "Lu et approuvé"</div>
            </div>
        </div>
    </div>

</body>
</html>