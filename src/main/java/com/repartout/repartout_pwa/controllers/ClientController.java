package com.repartout.repartout_pwa.controllers;

import com.repartout.repartout_pwa.entities.Client;
import com.repartout.repartout_pwa.repositories.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientRepository clientRepository;

    // 1. Afficher la liste
    @GetMapping
    public String listClients(Model model) {
        List<Client> clients = clientRepository.findAll();
        model.addAttribute("clients", clients);
        return "clients/list";
    }

    // 2. Afficher le formulaire d'ajout
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("client", new Client());
        return "clients/form";
    }

    // 3. Traiter l'enregistrement (Ajout ET Mise à jour)
    @PostMapping("/save")
    public String saveClient(@ModelAttribute("client") Client client) {
        // save() fait un "insert" si l'ID est nouveau, ou un "update" si l'ID existe déjà
        clientRepository.save(client);
        return "redirect:/clients";
    }

    // 4. Afficher le formulaire de modification (NOUVEAU)
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Optional<Client> client = clientRepository.findById(id);
        if (client.isPresent()) {
            model.addAttribute("client", client.get());
            return "clients/form";
        }
        return "redirect:/clients?error=ClientNotFound";
    }

    // 5. Supprimer un client (NOUVEAU)
    @GetMapping("/delete/{id}")
    public String deleteClient(@PathVariable("id") String id) {
        clientRepository.deleteById(id);
        return "redirect:/clients";
    }
}