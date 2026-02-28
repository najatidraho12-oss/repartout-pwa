package com.repartout.repartout_pwa.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entité JPA représentant une machine sous contrat de maintenance
 */
@Entity
@Table(name = "machines")
public class Machine implements Serializable {
    
	private static final long serialVersionUID = 1L;
    
    /**
     * Numéro de série (clé primaire)
     */
    @Id
    @Column(name = "numero_serie", length = 100)
    private String numeroSerie;
    
    /**
     * Marque de la machine
     */
    @Column(name = "marque", length = 255)
    private String marque;
    
    /**
     * Modèle de la machine
     */
    @Column(name = "modele", length = 255)
    private String modele;
    
    /**
     * Description de la machine
     */
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    /**
     * Date de fabrication
     */
    @Column(name = "date_fabrication")
    private LocalDate dateFabrication;
    
    /**
     * Date de fin de maintenance
     */
    @Column(name = "date_fin_maintenance")
    private LocalDate dateFinMaintenance;
    
    /**
     * Notes
     */
    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
    
    /**
     * Client associé (clé étrangère)
     * Plusieurs machines peuvent appartenir à un même client
     */
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "numero_client", nullable = false)
    private Client client;
    
    /**
     * Relation avec les demandes d'intervention
     * Une machine peut avoir plusieurs demandes d'intervention
     */
    @OneToMany(mappedBy = "machine", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<DemandeIntervention> demandes = new ArrayList<>();
    
    // ============ CONSTRUCTEURS ============
    
    /**
     * Constructeur par défaut
     */
    public Machine() {
    }
    
    /**
     * Constructeur avec les paramètres
     */
    public Machine(String numeroSerie, String marque, String modele) {
        this.numeroSerie = numeroSerie;
        this.marque = marque;
        this.modele = modele;
    }
    
    // ============ GETTERS ET SETTERS ============
    
    public String getNumeroSerie() {
        return numeroSerie;
    }
    
    public void setNumeroSerie(String numeroSerie) {
        this.numeroSerie = numeroSerie;
    }
    
    public String getMarque() {
        return marque;
    }
    
    public void setMarque(String marque) {
        this.marque = marque;
    }
    
    public String getModele() {
        return modele;
    }
    
    public void setModele(String modele) {
        this.modele = modele;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public LocalDate getDateFabrication() {
        return dateFabrication;
    }
    
    public void setDateFabrication(LocalDate dateFabrication) {
        this.dateFabrication = dateFabrication;
    }
    
    public LocalDate getDateFinMaintenance() {
        return dateFinMaintenance;
    }
    
    public void setDateFinMaintenance(LocalDate dateFinMaintenance) {
        this.dateFinMaintenance = dateFinMaintenance;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public Client getClient() {
        return client;
    }
    
    public void setClient(Client client) {
        this.client = client;
    }
    
    public List<DemandeIntervention> getDemandes() {
        return demandes;
    }
    
    public void setDemandes(List<DemandeIntervention> demandes) {
        this.demandes = demandes;
    }
    
    // ============ MÉTHODES UTILITAIRES ============
    
    @Override
    public String toString() {
        return "Machine{" +
                "numeroSerie='" + numeroSerie + '\'' +
                ", marque='" + marque + '\'' +
                ", modele='" + modele + '\'' +
                ", dateFinMaintenance=" + dateFinMaintenance +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Machine machine = (Machine) o;
        return numeroSerie != null && numeroSerie.equals(machine.numeroSerie);
    }
    
    @Override
    public int hashCode() {
        return numeroSerie != null ? numeroSerie.hashCode() : 0;
    }
}
