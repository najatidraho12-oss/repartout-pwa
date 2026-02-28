package com.repartout.repartout_pwa.repositories;

import com.repartout.repartout_pwa.entities.Machine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MachineRepository extends JpaRepository<Machine, String> {
    // Spring génère automatiquement : save, findAll, findById, deleteById
    
    // Équivalent de findByClientNumeroClient dans votre ancien DAO
    List<Machine> findByClientNumeroClient(Long numeroClient);
}