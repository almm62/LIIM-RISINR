/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.EquipoImagenologia;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositorio para la entidad EquipoImagenologia.
 * 
 * Esta interfaz hereda JpaRepository, proporcionando métodos CRUD y consultas
 * personalizadas sobre la entidad EquipoImagenologia. Permite acceder a los datos
 * de equipos de imagenología almacenados en la base de datos.
 * 
 * Autor: María de Jesús Rebolledo Bustillo
 */
@Repository
public interface EquipoImagenologiaRepository extends JpaRepository<EquipoImagenologia, String> {
    @Override
    List<EquipoImagenologia> findAll();
    EquipoImagenologia findByNombre(String Nombre);
    List<EquipoImagenologia> findByMarca(String marca);
    List<EquipoImagenologia> findByModelo(String modelo);
    List<EquipoImagenologia> findByModalidad(String modalidad);
    List<EquipoImagenologia> findByFechaInstalacion(Date fechaInstalacion); 
    List<EquipoImagenologia> findByEstado(String estado);
    EquipoImagenologia findBynSerie(String nSerie);

    
}
