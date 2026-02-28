package com.repartout.repartout_pwa.controllers;

import com.repartout.repartout_pwa.entities.Machine;
import com.repartout.repartout_pwa.repositories.MachineRepository;
import com.repartout.repartout_pwa.repositories.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/machines")
public class MachineController {

    @Autowired
    private MachineRepository machineRepository;

    @Autowired
    private ClientRepository clientRepository;

    // Afficher la liste de toutes les machines
    @GetMapping
    public String listMachines(Model model) {
        model.addAttribute("machines", machineRepository.findAll());
        return "machines/list";
    }

    // Afficher le formulaire pour ajouter une nouvelle machine
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("machine", new Machine());
        model.addAttribute("clients", clientRepository.findAll()); // Nécessaire pour le <select>
        return "machines/form";
    }

    // Sauvegarder ou mettre à jour une machine
    @PostMapping("/save")
    public String saveMachine(@ModelAttribute("machine") Machine machine) {
        machineRepository.save(machine);
        return "redirect:/machines";
    }

    // Afficher le formulaire de modification
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Optional<Machine> machine = machineRepository.findById(id);
        if (machine.isPresent()) {
            model.addAttribute("machine", machine.get());
            model.addAttribute("clients", clientRepository.findAll());
            return "machines/form";
        }
        return "redirect:/machines";
    }

    // Supprimer une machine
    @GetMapping("/delete/{id}")
    public String deleteMachine(@PathVariable("id") String id) {
        machineRepository.deleteById(id);
        return "redirect:/machines";
    }
}