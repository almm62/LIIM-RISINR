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
 * Implementación de la interfaz del servicio de áreas de servicio.
 * 
 * Esta clase contiene la lógica para la gestión de áreas de servicio y permite
 * obtener información de un área específica a partir de su identificador.
 * 
 * Utiliza un repositorio para acceder a los datos persistentes de la base de datos.
 * 
 * 
 * Autor: Maria de Jesus Rebolledo Bustillo
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
