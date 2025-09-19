/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.AreaDeServicio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositorio para la entidad AreaDeServicio.
 * 
 * Esta interfaz extiende JpaRepository, proporcionando métodos CRUD y consultas
 * personalizadas sobre la entidad AreaDeServicio. Permite acceder a los datos
 * de las áreas de servicio almacenadas en la base de datos.
 * 
 * Autor: María de Jesús Rebolledo Bustillo
 */

@Repository
public interface AreaDeServicioRepository extends JpaRepository<AreaDeServicio, Integer> {

    AreaDeServicio findByIdArea(Integer id);
    
}
