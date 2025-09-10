/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service.areaDeServicio.implementatios;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.service.areaDeServicio.AreaDeServicioService;
import org.springframework.stereotype.Service;

/**
 *
 * @author vsfs2
 */

@Service
public class AreaDeServicioServiceImpl implements AreaDeServicioService{

   
    private final AreaDeServicioRepository areaRepository; 
    
    public AreaDeServicioServiceImpl(AreaDeServicioRepository areaRepository) {
        this.areaRepository = areaRepository;
    }
    
    @Override
    public AreaDeServicio consultarPorID(Integer idArea){
        return areaRepository.findByIdArea(idArea);  
    }
    
}
