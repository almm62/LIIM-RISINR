package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Domicilio;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Domicilio.
 * Consulta informacion relacionada con el Domicilio de los Pacientes
 * de pacientes, usuarios o instituciones médicas en el sistema.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface DomicilioRepository extends JpaRepository<Domicilio, String>{
    
}
