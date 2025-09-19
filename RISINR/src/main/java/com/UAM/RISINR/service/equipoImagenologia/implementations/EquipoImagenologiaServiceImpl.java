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
import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaDTO;
import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaRequest;
import com.UAM.RISINR.repository.EquipoImagenologiaRepository;
import com.UAM.RISINR.service.areaDeServicio.AreaDeServicioService;
import com.UAM.RISINR.service.equipoImagenologia.EquipoImagenologiaService;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * Implementación de la interfaz del servicio de Equipos de Imagenología.
 * Esta clase se encarga de la lógica de negocio relacionada con los equipos,
 * incluyendo la consulta, creación, edición, validación y conversión a DTO.
 * 
 * También registra eventos de la aplicación y maneja la serialización de los datos
 * para el registro en JSON.
 * 
 * Autor: María de Jesús Rebolledo Bustillo
 */
@Service
public class EquipoImagenologiaServiceImpl implements EquipoImagenologiaService{
    
     /** Servicio para manejar las áreas de servicio */
    private final AreaDeServicioService areaService; 
    
    /** Repositorio de equipos de imagenología */
    private final EquipoImagenologiaRepository repository; 
    
    /** Servicio para registrar eventos */
    private final RegistroEventoService registroEvento; 
    
    /** Mapper para convertir objetos a JSON */
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
    
       
    /** Marca de tiempo para registrar los eventos */
    private long hora = 0;
    

     /**
     * Constructor que inicializa la implementación del servicio con los servicios
     * y repositorios necesarios.
     * 
     * @param areaService servicio de áreas de servicio
     * @param repository repositorio de equipos de imagenología
     * @param registroEvento servicio para registrar eventos
     * @param objtMapper mapper para convertir objetos a JSON
     */
    public EquipoImagenologiaServiceImpl(AreaDeServicioService areaService, EquipoImagenologiaRepository repository, RegistroEventoService registroEvento,ObjectMapper objtMapper ) {
        this.areaService = areaService;
        this.repository = repository;
        this.registroEvento = registroEvento;
        this.objMapper = objtMapper; 
    }
    
    /**
     * Consulta todos los equipos de imagenología existentes y los convierte a DTO.
     * Registra un evento de consulta exitosa.
     * 
     * @return lista de equipos en formato DTO
     */
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
    
        /**
     * Agrega un nuevo equipo de imagenología.
     * 
     * Este método realiza las siguientes acciones:
     * 1. Verifica si ya existe un equipo con el mismo número de serie. Si existe, lanza
     *    una excepción ResourceFoundException y registra el evento correspondiente.
     * 2. Valida que todos los campos obligatorios del request sean correctos mediante
     *    el método validacionDatos. Si no son válidos, lanza una excepción IncompleteFormException.
     * 3. Extrae los datos del request y crea la entidad EquipoImagenologia.
     * 4. Guarda el equipo en la base de datos y convierte la entidad a DTO.
     * 5. Registra un evento indicando que el equipo fue agregado exitosamente.
     * 
     * @param equipoRequest Datos del equipo a agregar
     * @return DTO del equipo agregado
     */
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
    
    /**
     * Edita un equipo de imagenología existente.
     * 
     * El método realiza las siguientes operaciones:
     * 1. Verifica si el equipo existe; si no, lanza ResourceNotFoundException.
     * 2. Valida los campos del request; si algún campo es inválido, lanza IncompleteFormException.
     * 3. Actualiza la entidad con los datos del request y guarda los cambios.
     * 4. Convierte la entidad actualizada a DTO.
     * 5. Registra un evento indicando la edición exitosa.
     * 
     * @param equipoRequest Datos del equipo a editar
     * @return DTO del equipo editado
     */
    @Override
    public EquipoImagenologiaDTO  edit(EquipoImagenologiaRequest equipoRequest){ 
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
    
     
     /**
     * Convierte una entidad EquipoImagenologia a su DTO correspondiente.
     * 
     * @param eqp entidad a convertir
     * @return DTO con los datos del equipo
     */
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

    /**
     * Valida si existe un equipo con el número de serie proporcionado.
     * 
     * @param nSerie número de serie del equipo
     * @return equipo encontrado o null si no existe
     */
   public EquipoImagenologia  validarEquipo(String nSerie){
        EquipoImagenologia equipo = repository.findBynSerie(nSerie);
        return equipo;
   }
   
   /**
     * Valida si existe un área con el identificador proporcionado.
     * 
     * @param idArea identificador del área
     * @return área encontrada o null si no existe
     */
   public AreaDeServicio  validarArea(Integer idArea){
        AreaDeServicio area = areaService.consultarPorID(idArea);
        return area;
   }
   
   
   /**
     * Extrae los datos del request y crea una entidad EquipoImagenologia lista para guardar.
     * 
     * @param equipoRequest datos del equipo
     * @return entidad EquipoImagenologia
     */
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
   
   /**
     * Valida los datos del request.
     * Retorna false si algún campo obligatorio es nulo, vacío o inválido
     * (por ejemplo, "0" para modalidad o estado, o idArea inexistente).
     * 
     * @param request request con los datos del equipo
     * @return true si los datos son válidos, false en caso contrario
     */
    
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
