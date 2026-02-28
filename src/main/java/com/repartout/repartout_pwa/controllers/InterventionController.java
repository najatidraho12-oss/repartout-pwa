package com.repartout.repartout_pwa.controllers;

import com.repartout.repartout_pwa.entities.DemandeIntervention;
import com.repartout.repartout_pwa.entities.Machine;
import com.repartout.repartout_pwa.repositories.DemandeInterventionRepository;
import com.repartout.repartout_pwa.repositories.MachineRepository;
import com.repartout.repartout_pwa.service.TelediagService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/interventions")
public class InterventionController {

    @Autowired
    private DemandeInterventionRepository interventionRepository;

    @Autowired
    private MachineRepository machineRepository;

    @Autowired
    private TelediagService telediagService;

    // 1. Liste avec filtres (Recherche par entreprise et État)
    @GetMapping
    public String list(
            @RequestParam(name = "etat", required = false) DemandeIntervention.EtatIntervention etat,
            @RequestParam(name = "search", required = false) String search,
            Model model) {
        
        List<DemandeIntervention> list;
        boolean hasSearch = (search != null && !search.isEmpty());
        boolean hasEtat = (etat != null);

        if (hasSearch && hasEtat) {
            list = interventionRepository.findByMachineClientNomEntrepriseContainingIgnoreCaseAndEtat(search, etat);
        } else if (hasSearch) {
            list = interventionRepository.findByMachineClientNomEntrepriseContainingIgnoreCase(search);
        } else if (hasEtat) {
            list = interventionRepository.findByEtat(etat);
        } else {
            list = interventionRepository.findAllByOrderByDateDemandeDesc();
        }
        
        model.addAttribute("interventions", list);
        model.addAttribute("etats", DemandeIntervention.EtatIntervention.values());
        model.addAttribute("selectedEtat", etat);
        model.addAttribute("searchTerm", search);
        
        return "interventions/list";
    }

    // 2. Formulaire d'ajout
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("intervention", new DemandeIntervention());
        model.addAttribute("machines", machineRepository.findAll());
        model.addAttribute("etats", DemandeIntervention.EtatIntervention.values());
        return "interventions/form";
    }

    // 3. Enregistrer / Sauvegarder
    @PostMapping("/save")
    public String save(@ModelAttribute("intervention") DemandeIntervention intervention, RedirectAttributes redirectAttributes) {
        
        // Vérification du contrat de maintenance de la machine
        if (intervention.getMachine() != null) {
            Machine machineAssociee = machineRepository.findById(intervention.getMachine().getNumeroSerie()).orElse(null);
            if (machineAssociee != null && machineAssociee.getDateFinMaintenance() != null && 
                machineAssociee.getDateFinMaintenance().isBefore(LocalDate.now())) {
                
                redirectAttributes.addFlashAttribute("error", 
                    "Attention : Le contrat de maintenance a expiré le " + machineAssociee.getDateFinMaintenance());
                return "redirect:/interventions/add";
            }
        }

        interventionRepository.save(intervention);
        return "redirect:/interventions";
    }

    // 4. Formulaire de modification
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Optional<DemandeIntervention> inter = interventionRepository.findById(id);
        if (inter.isPresent()) {
            model.addAttribute("intervention", inter.get());
            model.addAttribute("machines", machineRepository.findAll());
            model.addAttribute("etats", DemandeIntervention.EtatIntervention.values());
            return "interventions/form";
        }
        return "redirect:/interventions";
    }

    // 5. Supprimer une intervention
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id) {
        interventionRepository.deleteById(id);
        return "redirect:/interventions";
    }

    // 6. Impression du rapport / Fiche d'intervention
    @GetMapping("/print/{id}")
    public String printIntervention(@PathVariable("id") String id, Model model) {
        Optional<DemandeIntervention> inter = interventionRepository.findById(id);
        if (inter.isPresent()) {
            model.addAttribute("inter", inter.get());
            return "interventions/report";
        }
        return "redirect:/interventions";
    }
    
    // 7. Action de TÉLÉDIAGNOSTIC (Nouveau)
    @PostMapping("/telediag")
    public String executerTelediag(@RequestParam("numeroIntervention") String id, RedirectAttributes redirectAttributes) {
        Optional<DemandeIntervention> interOpt = interventionRepository.findById(id);
        
        if (interOpt.isPresent()) {
            DemandeIntervention inter = interOpt.get();
            
            // Appel au service de diagnostic intelligent
            String resultat = telediagService.analyserProbleme(inter.getDescriptionProbleme());
            
            // Mise à jour des notes de l'intervention avec le résultat du diagnostic
            String signature = "\n[🤖 TELEDIAG - " + LocalDateTime.now() + "] : ";
            inter.setNotes((inter.getNotes() != null ? inter.getNotes() : "") + signature + resultat);
            
            interventionRepository.save(inter);
            redirectAttributes.addFlashAttribute("diagMessage", "Analyse terminée avec succès.");
        }
        
        return "redirect:/interventions/edit/" + id + "?diagSuccess=true";
    }
}