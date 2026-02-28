package com.repartout.repartout_pwa.entities;

import java.io.Serializable;

/**
 * Classe représentant les informations de diagnostic TELEDIAG
 * 
 * Cette classe encapsule les données de diagnostic fournies par le système TELEDIAG
 * du fabricant pour aider au diagnostic et à la réparation des machines.
 */
public class DiagnosticInfo implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String numeroSerie;
    private String codeErreur;
    private String description;
    private String severite;
    private String[] actionssuggeres;
    private String nomMachine;
    private String localisation;
    
    /**
     * Constructeur par défaut
     */
    public DiagnosticInfo() {
    }
    
    /**
     * Constructeur complet
     */
    public DiagnosticInfo(String numeroSerie, String codeErreur, String description, 
                          String severite, String[] actionssuggeres) {
        this.numeroSerie = numeroSerie;
        this.codeErreur = codeErreur;
        this.description = description;
        this.severite = severite;
        this.actionssuggeres = actionssuggeres;
    }
    
    // Getters et Setters
    
    public String getNumeroSerie() {
        return numeroSerie;
    }
    
    public void setNumeroSerie(String numeroSerie) {
        this.numeroSerie = numeroSerie;
    }
    
    public String getCodeErreur() {
        return codeErreur;
    }
    
    public void setCodeErreur(String codeErreur) {
        this.codeErreur = codeErreur;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getSeverite() {
        return severite;
    }
    
    public void setSeverite(String severite) {
        this.severite = severite;
    }
    
    public String[] getActionsSuggeres() {
        return actionssuggeres;
    }
    
    public void setActionsSuggeres(String[] actionssuggeres) {
        this.actionssuggeres = actionssuggeres;
    }
    
    public String getNomMachine() {
        return nomMachine;
    }
    
    public void setNomMachine(String nomMachine) {
        this.nomMachine = nomMachine;
    }
    
    public String getLocalisation() {
        return localisation;
    }
    
    public void setLocalisation(String localisation) {
        this.localisation = localisation;
    }
    
    /**
     * Retourne une représentation textuelle du diagnostic
     */
    @Override
    public String toString() {
        return "DiagnosticInfo{" +
                "numeroSerie='" + numeroSerie + '\'' +
                ", codeErreur='" + codeErreur + '\'' +
                ", description='" + description + '\'' +
                ", severite='" + severite + '\'' +
                '}';
    }
}