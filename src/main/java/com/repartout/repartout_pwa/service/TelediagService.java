package com.repartout.repartout_pwa.service;

import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

/**
 * Service de Télédiagnostic - Assistant Logistique pour Techniciens.
 * Ce service permet d'anticiper les besoins en pièces de rechange
 * avant le départ en intervention sur site.
 */
@Service
public class TelediagService {

    // Simulation d'une base de connaissances technique
    private static final Map<String, String> CATALOGUE_PANNES = new HashMap<>();

    static {
        // Format : "CODE" -> "Symptôme technique | Liste de colisage (Pièces)"
        CATALOGUE_PANNES.put("Surchauffe", "Surchauffe thermique du stator moteur. | Sonde de température KTY84, Ventilateur extracteur 120mm.");
        CATALOGUE_PANNES.put("tension", "Surtension ou court-circuit sur variateur. | Lot de fusibles 16A (Action rapide), Module IGBT de rechange.");
        CATALOGUE_PANNES.put("sécurité", "Interruption de la boucle de sécurité laser. | Capteur de proximité Omron, Câble M12 5 broches (5m).");
        CATALOGUE_PANNES.put("FUITE", "Rupture d'étanchéité sur circuit hydraulique. | Mallette de joints toriques Nitrile, 2L d'huile hydraulique ISO 46.");
        CATALOGUE_PANNES.put("VIBRATION", "Déséquilibre de l'axe de rotation principal. | Kit de roulements à billes auto-aligneurs, Comparateur à cadran.");
        CATALOGUE_PANNES.put("ALIMENTATION", "Chute de tension sur l'unité de contrôle. | Alimentation Rail DIN 24V DC, Multimètre de précision.");
        CATALOGUE_PANNES.put("CONNEXION", "Perte de signal sur le bus de données. | Terminateur de bus, Testeur de continuité réseau.");
    }

    /**
     * Analyse la description fournie par le dispatcher pour orienter le technicien.
     * @param description Les symptômes rapportés par le client au téléphone.
     * @return Une recommandation formatée en HTML pour l'interface.
     */
    public String analyserProbleme(String description) {
        if (description == null || description.trim().isEmpty()) {
            return "<i>Aucune donnée technique saisie pour l'analyse.</i>";
        }

        String input = description.toUpperCase();
        
        for (Map.Entry<String, String> entry : CATALOGUE_PANNES.entrySet()) {
            if (input.contains(entry.getKey())) {
                String[] data = entry.getValue().split("\\|");
                StringBuilder response = new StringBuilder();
                response.append("<div style='color: #111; font-weight: 600;'>")
                        .append("✅ DIAGNOSTIC : ").append(data[0].trim())
                        .append("</div>")
                        .append("<div style='margin-top: 5px; color: #e60023;'>")
                        .append("📦 PIÈCES À CHARGER : ").append(data.length > 1 ? data[1].trim() : "Outillage standard.")
                        .append("</div>");
                return response.toString();
            }
        }

        return "<div style='color: #666;'>⚠️ <b>ALERTE :</b> Symptôme non répertorié. Prévoir l'unité de diagnostic mobile et les consommables de base.</div>";
    }

    /**
     * Permet à l'interface d'afficher la légende des codes supportés.
     */
    public Map<String, String> getToutesLesRegles() {
        return CATALOGUE_PANNES;
    }
}