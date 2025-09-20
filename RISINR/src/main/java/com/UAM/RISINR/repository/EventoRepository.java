/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Evento;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author vsfs2
 */
public interface EventoRepository extends JpaRepository <Evento, Integer>{
    

    Evento findByIdEvento(Integer id);
   
}
