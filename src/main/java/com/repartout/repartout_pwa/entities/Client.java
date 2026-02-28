package com.repartout.repartout_pwa.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entité JPA représentant un client de REPARTOUT
 */
@Entity
@Table(name = "clients")
public class Client implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * Numéro de client (Clé primaire auto-incrémentée)
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "numero_client")
    private Long numeroClient; // Changé de String à Long pour l'auto-incrément
    
    @Column(name = "nom_entreprise", nullable = false, length = 255)
    private String nomEntreprise;
    
    @Column(name = "adresse_postale", length = 500)
    private String adressePostale;
    
    @Column(name = "email", length = 255)
    private String email;
    
    @Column(name = "telephone", length = 20)
    private String telephone;
    
    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
    
    @OneToMany(mappedBy = "client", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Machine> machines = new ArrayList<>();
    
    // ============ CONSTRUCTEURS ============
    
    public Client() {
    }
    
    public Client(String nomEntreprise) {
        this.nomEntreprise = nomEntreprise;
    }
    
    // ============ GETTERS ET SETTERS ============
    
    public Long getNumeroClient() {
        return numeroClient;
    }
    
    public void setNumeroClient(Long numeroClient) {
        this.numeroClient = numeroClient;
    }
    
    public String getNomEntreprise() {
        return nomEntreprise;
    }
    
    public void setNomEntreprise(String nomEntreprise) {
        this.nomEntreprise = nomEntreprise;
    }
    
    public String getAdressePostale() {
        return adressePostale;
    }
    
    public void setAdressePostale(String adressePostale) {
        this.adressePostale = adressePostale;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public List<Machine> getMachines() {
        return machines;
    }
    
    public void setMachines(List<Machine> machines) {
        this.machines = machines;
    }
    
    @Override
    public String toString() {
        return "Client{" +
                "id=" + numeroClient +
                ", nom='" + nomEntreprise + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Client client = (Client) o;
        return numeroClient != null && numeroClient.equals(client.numeroClient);
    }
}