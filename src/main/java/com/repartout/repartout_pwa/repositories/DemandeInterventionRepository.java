package com.repartout.repartout_pwa.repositories;

import com.repartout.repartout_pwa.entities.DemandeIntervention;
import com.repartout.repartout_pwa.entities.DemandeIntervention.EtatIntervention;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DemandeInterventionRepository extends JpaRepository<DemandeIntervention, String> {
    
    List<DemandeIntervention> findAllByOrderByDateDemandeDesc();

    // Filtre par état
    List<DemandeIntervention> findByEtat(EtatIntervention etat);
 // Recherche les interventions dont le nom de l'entreprise du client contient la chaîne recherchée
    List<DemandeIntervention> findByMachineClientNomEntrepriseContainingIgnoreCase(String nom);
    //recherche avec etat et nom
    List<DemandeIntervention> findByMachineClientNomEntrepriseContainingIgnoreCaseAndEtat(String nom, DemandeIntervention.EtatIntervention etat);
}



