/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.EquipoImagenologia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author vsfs2
 */

@Repository
public interface AreaDeServicioRepository extends JpaRepository<AreaDeServicio, Integer> {

    AreaDeServicio findByIdArea(Integer id);
    
}
