package com.UAM.RISINR.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Paciente;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Paciente.
 * Proporciona métodos para consultar y administrar información de pacientes
 * en el sistema, incluyendo búsquedas por nombre y apellido.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface PacienteRepository extends JpaRepository<Paciente,String>{
    List<Paciente> findByNombreContaining(String nombre);
    List<Paciente> findByApellidoPaternoContaining(String apellido);
    List<Paciente> findByNombreContainingAndApellidoPaternoContaining(String nombre, String apellido);
    
}
