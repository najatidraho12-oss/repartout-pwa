package com.repartout.repartout_pwa.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Entité JPA représentant une demande d'intervention.
 * Format automatique du numéro : AANNNN généré à la création.
 */
@Entity
@Table(name = "demandes_intervention")
public class DemandeIntervention implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * Clé primaire technique.
     * Pour éviter l'écrasement des données, nous utilisons un ID auto-incrémenté 
     * en interne, tout en conservant votre champ 'numeroIntervention' pour l'affichage métier.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

   

    @Column(name = "date_demande", nullable = false)
    private LocalDateTime dateDemande;

    @Column(name = "description_probleme", columnDefinition = "TEXT")
    private String descriptionProbleme;

    @Column(name = "date_intervention_previsionnelle")
    private LocalDate dateInterventionPrevisionnelle;

    @Column(name = "nom_technicien", length = 255)
    private String nomTechnicien;

    @Enumerated(EnumType.STRING)
    @Column(name = "etat", nullable = false)
    private EtatIntervention etat;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "numero_serie", nullable = false)
    private Machine machine;

    public enum EtatIntervention {
        EN_ATTENTE("En attente"),
        EN_COURS("En cours"),
        REALISEE("Réalisée"),
        ANNULEE("Annulée");
        
        private final String label;
        EtatIntervention(String label) { this.label = label; }
        public String getLabel() { return label; }
    }

    public DemandeIntervention() {
        this.dateDemande = LocalDateTime.now();
        this.etat = EtatIntervention.EN_ATTENTE;
    }

   

    // ============ GETTERS ET SETTERS ============

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

   
    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }

    public String getDescriptionProbleme() { return descriptionProbleme; }
    public void setDescriptionProbleme(String descriptionProbleme) { this.descriptionProbleme = descriptionProbleme; }

    public LocalDate getDateInterventionPrevisionnelle() { return dateInterventionPrevisionnelle; }
    public void setDateInterventionPrevisionnelle(LocalDate dateInterventionPrevisionnelle) { this.dateInterventionPrevisionnelle = dateInterventionPrevisionnelle; }

    public String getNomTechnicien() { return nomTechnicien; }
    public void setNomTechnicien(String nomTechnicien) { this.nomTechnicien = nomTechnicien; }

    public EtatIntervention getEtat() { return etat; }
    public void setEtat(EtatIntervention etat) { this.etat = etat; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Machine getMachine() { return machine; }
    public void setMachine(Machine machine) { this.machine = machine; }
}