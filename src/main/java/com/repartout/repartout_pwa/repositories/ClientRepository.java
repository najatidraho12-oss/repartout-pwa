package com.repartout.repartout_pwa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.repartout.repartout_pwa.entities.Client;

public interface ClientRepository extends JpaRepository<Client, String> {
}