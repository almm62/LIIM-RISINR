/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.EquipoImagenologiaDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.EquipoImagenologiaRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author vsfs2
 */
@Service
public class EquipoImagenologiaManager {
    
    @Autowired
    private EquipoImagenologiaRepository repository; 
    
    @Autowired
    private AreaDeServicioManager areaManager;
    
    
    @Transactional(readOnly = true)
    public List<EquipoImagenologiaDTO> consultarTodos(){
 
        List<EquipoImagenologia> equipos = repository.findAll();
        List<EquipoImagenologiaDTO> equiposDTO = new ArrayList();
        
        for (EquipoImagenologia eqp: equipos){
            EquipoImagenologiaDTO equipoDTO = convertirDTO(eqp);
            equiposDTO.add(equipoDTO);
        }
        return equiposDTO;
    }   
    
    
    public EquipoImagenologiaDTO add(Map<String, String> formData){  
        String nSerie = formData.get("nserEQP");
        EquipoImagenologia equipo;
        if(validarEquipo(nSerie) == null){
            equipo = extraerDatos(formData);
            repository.save(equipo);
            return convertirDTO(equipo);
        } else{
            return null;
        } 
    }
    
    public EquipoImagenologia  edit(Map<String, String> formData){
       String nSerie = formData.get("nserEQP");
       EquipoImagenologia equipo = validarEquipo(nSerie);
       if(equipo == null){
           return null;
       }
           
       formData.forEach((campo, valor) -> {
        switch (campo) {
            case "nomEQP": equipo.setNombre(valor); break;
            case "modeloEQP": equipo.setModelo(valor); break;
            case "marcaEQP": equipo.setMarca(valor); break;
            case "modalEQP": equipo.setModalidad(valor); break;
            case "edoEqp": equipo.setEstado(valor); break;
            case "areEqp":
                var area = areaManager.consultarPorID(valor);
                if (area != null) {
                    equipo.setAreaDeServicioidArea(area);
                }
                break;
        }
    });      
        repository.save(equipo);
        return equipo;
   }
     

    
    public EquipoImagenologiaDTO convertirDTO(EquipoImagenologia eqp){
        String nSerie = eqp.getnSerie();
        String nombreEquipo = eqp.getNombre();
        String marca = eqp.getMarca();
        String modelo = eqp.getModelo();
        String modalidad = eqp.getModalidad();
        Integer idArea = eqp.getAreaDeServicioidArea().getIdArea();
        String nombreArea = eqp.getAreaDeServicioidArea().getNombre(); 
        String estado = eqp.getEstado();
        Date fechaInstalacion = eqp.getFechaInstalacion();

        EquipoImagenologiaDTO equipoDTO = new EquipoImagenologiaDTO(nSerie, nombreEquipo, marca, modelo, modalidad, idArea, nombreArea, estado,fechaInstalacion);

        return equipoDTO;  
    }

   public EquipoImagenologia extraerDatos(Map<String, String> formData){
        String nSerie = formData.get("nserEQP");
        String nombre = formData.get("nomEQP");
        String marca = formData.get("marcaEQP");
        String modelo = formData.get("modeloEQP");
        String modalidad = formData.get("modalEQP");
        AreaDeServicio area = areaManager.consultarPorID(formData.get("areEqp"));  
        String estado = formData.get("edoEqp");
        
        EquipoImagenologia equipo = new EquipoImagenologia(nSerie, nombre, marca, modelo, modalidad, estado, area);
       
       return equipo;
   }
   
   public EquipoImagenologia  validarEquipo(String nSerie){
       
        EquipoImagenologia equipo = repository.findBynSerie(nSerie);
        return equipo;
 
   }
   
   
   
}
