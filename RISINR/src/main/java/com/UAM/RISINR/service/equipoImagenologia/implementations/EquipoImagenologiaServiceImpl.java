/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service.equipoImagenologia.implementations;

import com.UAM.RISINR.exceptions.IncompleteFormException;
import com.UAM.RISINR.exceptions.ResourceNotFoundException;
import com.UAM.RISINR.exceptions.ResourceFoundException;
import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.EquipoImagenologiaDTO;
import com.UAM.RISINR.model.dto.EquipoImagenologiaRequest;
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
import java.util.Set;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

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
    private static final int APLICACION_CONSULTA = 1;
    private static final int APLICACION_EDITAR = 2;
    private static final int APLICACION_CREAR = 3;
    
    //Eventos
    private static final int EQUIPO_AGREGADO_EXITOSAMENTE = 3;
    private static final int EQUIPO_EDITADO_EXITOSAMENTE = 4 ;
    private static final int CATALOGO_CONSULTADO_EXITOSAMENTE = 5;
    private static final int NUM_SERIE_EXISTENTE = 1004;
    private static final int NUM_SERIE_NO_EXISTE = 1005;
    private static final int INFORMACION_INCOMPLETA_AGREGAR= 1012;
    private static final int INFORMACION_INCOMPLETA_EDITAR = 1013;
    
    
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
    public EquipoImagenologiaDTO add(EquipoImagenologiaRequest equipoRequest){  
        hora =  System.currentTimeMillis();
        EquipoImagenologia equipo;
        EquipoImagenologiaDTO equipoDTO;
        String datos = "{}";
        String nSerie = equipoRequest.getnSerie();
        
        if(validarEquipo(nSerie) != null){
            registroEvento.log(NUM_SERIE_EXISTENTE, APLICACION_CREAR, hora, datos);
            throw new ResourceFoundException(1004); 
        }else{     
            boolean valido = validacionDatos(equipoRequest);
            if(valido == false){
                registroEvento.log(INFORMACION_INCOMPLETA_AGREGAR, APLICACION_CREAR, hora, datos);
                throw new IncompleteFormException(1012); 
            }
            
            equipo = extraerDatos(equipoRequest);
            repository.save(equipo);
            equipoDTO = convertirDTO(equipo);
            try {
                 datos = objMapper.writeValueAsString(equipoRequest); // JSON correcto
                 System.out.println(datos);
            } catch (JsonProcessingException e) {
                e.printStackTrace();  // valor por defecto para no romper la app
            }
            registroEvento.log(EQUIPO_AGREGADO_EXITOSAMENTE, APLICACION_CREAR, hora, datos);
            return equipoDTO;
        }
    }
    
    
    @Override
    public EquipoImagenologiaDTO  edit(@RequestBody EquipoImagenologiaRequest equipoRequest){ 
       hora =  System.currentTimeMillis();
        EquipoImagenologia equipo;
        EquipoImagenologiaDTO equipoDTO;
        String datos = "{}";
        String nSerie = equipoRequest.getnSerie();
        
        if(validarEquipo(nSerie) == null){
            registroEvento.log(NUM_SERIE_NO_EXISTE, APLICACION_EDITAR, hora, datos);
            throw new ResourceNotFoundException(1005);
        }else{
            boolean valido = validacionDatos(equipoRequest);
            if(valido == false){
                registroEvento.log(INFORMACION_INCOMPLETA_EDITAR, APLICACION_EDITAR, hora, datos);
                throw new IncompleteFormException(1013); 
            }
            
            
            equipo = repository.findBynSerie(nSerie);
            equipo.setNombre(equipoRequest.getNombreEquipo());
            equipo.setMarca(equipoRequest.getMarca());
            equipo.setModalidad(equipoRequest.getModalidad());
            equipo.setModelo(equipoRequest.getModelo());
            equipo.setEstado(equipoRequest.getEstado());
            equipo.setAreaDeServicioidArea(areaService.consultarPorID(equipoRequest.getIdArea()));
            repository.save(equipo);
            equipoDTO = convertirDTO(equipo);
            
            try {
                 datos = objMapper.writeValueAsString(equipoRequest); // JSON correcto
                 System.out.println(datos);
            } catch (JsonProcessingException e) {
                e.printStackTrace();  // valor por defecto para no romper la app
            }
            
            registroEvento.log(EQUIPO_EDITADO_EXITOSAMENTE, APLICACION_EDITAR, hora, datos);
            return equipoDTO;
        }
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

        EquipoImagenologiaDTO equipoDTO = new EquipoImagenologiaDTO(nSerie, nombreEquipo, marca, modelo, modalidad,idArea,nombreArea , estado,fechaInstalacion);

        return equipoDTO;  
    }

   
   public EquipoImagenologia  validarEquipo(String nSerie){
        EquipoImagenologia equipo = repository.findBynSerie(nSerie);
        return equipo;
   }
   
   public AreaDeServicio  validarArea(Integer idArea){
        AreaDeServicio area = areaService.consultarPorID(idArea);
        return area;
   }
   
   
   
   public EquipoImagenologia extraerDatos(EquipoImagenologiaRequest equipoRequest){
       EquipoImagenologia equipo = new EquipoImagenologia();
       Date fecha = new Date();
       
       equipo.setnSerie(equipoRequest.getnSerie());
       equipo.setNombre(equipoRequest.getNombreEquipo());
       equipo.setMarca(equipoRequest.getMarca());
       equipo.setModalidad(equipoRequest.getModalidad());
       equipo.setModelo(equipoRequest.getModelo());
       equipo.setEstado(equipoRequest.getEstado());
       equipo.setAreaDeServicioidArea(areaService.consultarPorID(equipoRequest.getIdArea()));
       equipo.setFechaInstalacion(fecha);

       return equipo;
   }
    
   public boolean validacionDatos(EquipoImagenologiaRequest request) {
    if (request == null) {
        return false;
    }

    if (request.getnSerie() == null || request.getnSerie().trim().isEmpty()) {
        return false;
    }
    if (request.getNombreEquipo() == null || request.getNombreEquipo().trim().isEmpty()) {
        return false;
    }
    if (request.getMarca() == null || request.getMarca().trim().isEmpty()) {
        return false;
    }
    if (request.getModelo() == null || request.getModelo().trim().isEmpty()) {
        return false;
    }

    // Modalidad: no nula, no vacía, no "0"
    if (request.getModalidad() == null || request.getModalidad().trim().isEmpty() || request.getModalidad().trim().equals("0")) {
        return false;
    }

    // idArea: no nulo y no 0
    if (validarArea(request.getIdArea()) == null) {
        return false;
    }

    // Estado: no nulo, no vacío, no "0"
    if (request.getEstado() == null || request.getEstado().trim().isEmpty() || request.getEstado().trim().equals("0")) {
        return false;
    }

    // Si pasó todas las validaciones
    return true;
}


   
   
   }
