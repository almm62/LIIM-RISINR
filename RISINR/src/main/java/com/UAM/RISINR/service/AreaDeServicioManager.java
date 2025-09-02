/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author vsfs2
 */

@Service
public class AreaDeServicioManager {
    
    @Autowired
    public AreaDeServicioRepository areaRepository;
    
    public AreaDeServicio consultarPorID(String id){
        Integer idArea = Integer.parseInt(id);
        return areaRepository.findByIdArea(idArea);  
    }
}
