package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Paciente;

public interface PacienteRepository extends JpaRepository<Paciente,String>{
    
}
