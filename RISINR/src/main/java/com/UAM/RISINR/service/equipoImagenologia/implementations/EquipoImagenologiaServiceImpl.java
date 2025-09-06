/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service.equipoImagenologia.implementations;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.EquipoImagenologiaDTO;
import com.UAM.RISINR.repository.EquipoImagenologiaRepository;
import com.UAM.RISINR.service.areaDeServicio.AreaDeServicioService;
import com.UAM.RISINR.service.equipoImagenologia.EquipoImagenologiaService;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author vsfs2
 */
@Service
public class EquipoImagenologiaServiceImpl implements EquipoImagenologiaService{
    
    private final AreaDeServicioService areaService; 
    private final EquipoImagenologiaRepository repository; 
    private final RegistroEventoService registroEvento; 
    private final ObjectMapper objMapper;
    
    // Aplicaciones
    private static final int APLICACION_CONSULTA = 2;
    private static final int APLICACION_EDITAR = 3;
    private static final int APLICACION_CREAR = 4;
    
    //Eventos
    private static final int EQUIPO_AGREGADO_EXITOSAMENTE = 5;
    private static final int EQUIPO_EDITADO_EXITOSAMENTE = 6  ;
    private static final int  CATALOGO_CONSULTADO_EXITOSAMENTE = 7;
    private static final int NUM_SERIE_EXISTENTE = 1004;
    private static final int EQUIPO_EDITADO_FALLIDAMENTE = 1005;
    
    
    private long hora = 0;
    


    public EquipoImagenologiaServiceImpl(AreaDeServicioService areaService, EquipoImagenologiaRepository repository, RegistroEventoService registroEvento,ObjectMapper objtMapper ) {
        this.areaService = areaService;
        this.repository = repository;
        this.registroEvento = registroEvento;
        this.objMapper = objtMapper; 
    }
    
    
    @Transactional(readOnly = true)
    @Override
    public List<EquipoImagenologiaDTO> consultarTodos(){
        
        hora =  System.currentTimeMillis();
        List<EquipoImagenologia> equipos = repository.findAll();
        List<EquipoImagenologiaDTO> equiposDTO = new ArrayList();
        
        for (EquipoImagenologia eqp: equipos){
            EquipoImagenologiaDTO equipoDTO = convertirDTO(eqp);
            equiposDTO.add(equipoDTO);
        }
        registroEvento.log(CATALOGO_CONSULTADO_EXITOSAMENTE, APLICACION_CONSULTA, hora, "{}");
        return equiposDTO;
    }   
    
    @Override
    public EquipoImagenologiaDTO add(Map<String, String> formData){  
        hora =  System.currentTimeMillis();
        String nSerie = formData.get("nserEQP");
        EquipoImagenologia equipo;
        String datos = "{}";
        if(validarEquipo(nSerie) == null){
            equipo = extraerDatos(formData);
            repository.save(equipo);
            EquipoImagenologiaDTO equipoDTO = convertirDTO(equipo);
            try {
                 datos = objMapper.writeValueAsString(equipoDTO); // JSON correcto
                 System.out.println(datos);
            } catch (JsonProcessingException e) {
                e.printStackTrace(); 
                     datos = "{}"; // valor por defecto para no romper la app
            }
            registroEvento.log(EQUIPO_AGREGADO_EXITOSAMENTE, APLICACION_CREAR, hora, datos);
            return equipoDTO;
        } else{
            registroEvento.log(NUM_SERIE_EXISTENTE, APLICACION_CREAR, hora, datos);
            return null;
        } 
    }
    
    @Override
    public EquipoImagenologiaDTO  edit(Map<String, String> formData){
       hora =  System.currentTimeMillis();
       String datos = "";
       String nSerie = formData.get("nserEQP");
       EquipoImagenologia equipo = validarEquipo(nSerie);
       if(equipo == null){
           registroEvento.log(EQUIPO_EDITADO_FALLIDAMENTE, APLICACION_EDITAR, hora, nSerie);
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
                var area = areaService.consultarPorID(valor);
                if (area != null) {
                    equipo.setAreaDeServicioidArea(area);
                }
                break;
        }
    });      
        repository.save(equipo);
        EquipoImagenologiaDTO equipoDTO = convertirDTO(equipo);
        try {
                 datos = objMapper.writeValueAsString(equipoDTO); // JSON correcto
                 System.out.println(datos);
        } catch (JsonProcessingException e) {
                e.printStackTrace(); 
                     datos = "{}"; // valor por defecto para no romper la app
            }
        
        registroEvento.log(EQUIPO_EDITADO_EXITOSAMENTE, APLICACION_EDITAR, hora, datos);
        return equipoDTO;
   }
     

    @Override
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
        AreaDeServicio area = areaService.consultarPorID(formData.get("areEqp"));  
        String estado = formData.get("edoEqp");
        
        EquipoImagenologia equipo = new EquipoImagenologia(nSerie, nombre, marca, modelo, modalidad, estado, area);
       
       return equipo;
   }
   
   public EquipoImagenologia  validarEquipo(String nSerie){
       
        EquipoImagenologia equipo = repository.findBynSerie(nSerie);
        return equipo;
 
   }
    
    
}
