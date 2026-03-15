package com.UAM.RISINR.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Paciente;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Paciente.
 * Proporciona métodos para consultar y administrar información de pacientes
 * en el sistema, incluyendo búsquedas por nombre y apellido.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface PacienteRepository extends JpaRepository<Paciente,String>{
    /**
     * Busca pacientes cuyo nombre contenga la cadena indicada (búsqueda parcial).
     * @param nombre Fragmento del nombre a buscar
     * @return Lista de Paciente con nombres que contienen el fragmento
     */
    List<Paciente> findByNombreContaining(String nombre);
    /**
     * Busca pacientes cuyo apellido paterno contenga la cadena indicada (búsqueda parcial).
     * @param apellido Fragmento del apellido paterno a buscar
     * @return Lista de Paciente con apellidos que contienen el fragmento
     */
    List<Paciente> findByApellidoPaternoContaining(String apellido);
    /**
     * Busca pacientes cuyo nombre y apellido paterno contengan las cadenas indicadas.
     * @param nombre Fragmento del nombre a buscar
     * @param apellido Fragmento del apellido paterno a buscar
     * @return Lista de Paciente que cumplen ambos criterios de búsqueda parcial
     */
    List<Paciente> findByNombreContainingAndApellidoPaternoContaining(String nombre, String apellido);
    
}
