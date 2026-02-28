package com.repartout.repartout_pwa.controllers;

import com.repartout.repartout_pwa.repositories.ClientRepository;
import com.repartout.repartout_pwa.repositories.MachineRepository;
import com.repartout.repartout_pwa.repositories.DemandeInterventionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private MachineRepository machineRepository;

    @Autowired
    private DemandeInterventionRepository interventionRepository;

    @GetMapping("/")
    public String index(Model model) {
        // On récupère les compteurs globaux
        model.addAttribute("nbClients", clientRepository.count());
        model.addAttribute("nbMachines", machineRepository.count());
        model.addAttribute("nbInterventions", interventionRepository.count());
        
        return "index"; // Vers /src/main/webapp/jsp/index.jsp
    }
}