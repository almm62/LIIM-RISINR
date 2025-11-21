package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Medico;
import com.UAM.RISINR.model.MedicoPK;

public interface MedicoRepository extends JpaRepository<Medico, MedicoPK> {
    
}
