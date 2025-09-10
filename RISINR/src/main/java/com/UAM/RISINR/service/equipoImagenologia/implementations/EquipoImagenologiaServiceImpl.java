/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.service.equipoImagenologia.implementations;

import com.UAM.RISINR.exceptions.EquipoImagenologia.ResourceNotFoundException;
import com.UAM.RISINR.exceptions.ResourceFoundException;
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
    private static final int APLICACION_CONSULTA = 2;
    private static final int APLICACION_EDITAR = 3;
    private static final int APLICACION_CREAR = 4;
    
    //Eventos
    private static final int EQUIPO_AGREGADO_EXITOSAMENTE = 5;
    private static final int EQUIPO_EDITADO_EXITOSAMENTE = 6  ;
    private static final int CATALOGO_CONSULTADO_EXITOSAMENTE = 7;
    private static final int NUM_SERIE_EXISTENTE = 1004;
    private static final int NUM_SERIE_NO_EXISTE = 1005;
    
    
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
    public EquipoImagenologiaDTO add(EquipoImagenologiaDTO equipoDTO){  
        hora =  System.currentTimeMillis();
        EquipoImagenologia equipo;
        AreaDeServicio area;
        String datos = "{}";
        String nSerie = equipoDTO.getnSerie();
        
        if(validarEquipo(nSerie) != null){
            registroEvento.log(NUM_SERIE_EXISTENTE, APLICACION_CREAR, hora, datos);
            throw new ResourceFoundException("El equipo con numero de serie "+ nSerie +  " ya ha sido registrado");
           
        }else{
            
            area = validarArea(equipoDTO.getIdArea());
            if(area == null){
                registroEvento.log(NUM_SERIE_EXISTENTE, APLICACION_CREAR, hora, datos);
                throw new ResourceNotFoundException("El area ingresada no existe"); 
            }
            equipo = extraerDatos(equipoDTO, area);
            repository.save(equipo);
            try {
                 datos = objMapper.writeValueAsString(equipoDTO); // JSON correcto
                 System.out.println(datos);
            } catch (JsonProcessingException e) {
                e.printStackTrace();  // valor por defecto para no romper la app
            }
            registroEvento.log(EQUIPO_AGREGADO_EXITOSAMENTE, APLICACION_CREAR, hora, datos);
            return equipoDTO;
        }
    }
    
    
    @Override
    public EquipoImagenologiaDTO  edit(@RequestBody EquipoImagenologiaDTO equipoDTO){ 
       hora =  System.currentTimeMillis();
        EquipoImagenologia equipo;
        AreaDeServicio area;
        String datos = "{}";
        String nSerie = equipoDTO.getnSerie();
        
        if(validarEquipo(nSerie) == null){
            registroEvento.log(NUM_SERIE_NO_EXISTE, APLICACION_EDITAR, hora, datos);
            throw new ResourceNotFoundException("El equipo con numero de serie "+ nSerie +  " ya ha sido registrado");
        }else{
            area = validarArea(equipoDTO.getIdArea());
            if(area == null){
                
                registroEvento.log(NUM_SERIE_NO_EXISTE, APLICACION_CREAR, hora, datos);
                throw new ResourceNotFoundException("El area ingresada no existe"); 
            }
            
            equipo = repository.findBynSerie(nSerie);
            equipo.setNombre(equipoDTO.getNombreEquipo());
            equipo.setMarca(equipoDTO.getMarca());
            equipo.setModalidad(equipoDTO.getModalidad());
            equipo.setModelo(equipoDTO.getModelo());
            equipo.setEstado(equipoDTO.getEstado());
            equipo.setAreaDeServicioidArea(area);
            equipo.setFechaInstalacion(equipoDTO.getFechaInstalacion());
            repository.save(equipo);
            
            try {
                 datos = objMapper.writeValueAsString(equipoDTO); // JSON correcto
                 System.out.println(datos);
            } catch (JsonProcessingException e) {
                e.printStackTrace();  // valor por defecto para no romper la app
            }
            
            registroEvento.log(EQUIPO_EDITADO_EXITOSAMENTE, APLICACION_CREAR, hora, datos);
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

        EquipoImagenologiaDTO equipoDTO = new EquipoImagenologiaDTO(nSerie, nombreEquipo, marca, modelo, modalidad, idArea, nombreArea, estado,fechaInstalacion);

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
   
   public EquipoImagenologia extraerDatos(EquipoImagenologiaDTO equipoDTO, AreaDeServicio area){
       EquipoImagenologia equipo = new EquipoImagenologia();
       
       equipo.setnSerie(equipoDTO.getnSerie());
       equipo.setNombre(equipoDTO.getNombreEquipo());
       equipo.setMarca(equipoDTO.getMarca());
       equipo.setModalidad(equipoDTO.getModalidad());
       equipo.setModelo(equipoDTO.getModelo());
       equipo.setEstado(equipoDTO.getEstado());
       equipo.setAreaDeServicioidArea(area);
       equipo.setFechaInstalacion(equipoDTO.getFechaInstalacion());

       return equipo;
   }
    
}
