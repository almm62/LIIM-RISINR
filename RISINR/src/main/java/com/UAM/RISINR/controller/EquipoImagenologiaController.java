/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaDTO;
import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaRequest;
import com.UAM.RISINR.service.equipoImagenologia.EquipoImagenologiaService;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controlador REST para manejar las operaciones relacionadas con
 * Equipos de Imagenología. 
 * Proporciona endpoints para consultar, agregar y editar equipos.
 * Utiliza el servicio EquipoImagenologiaService para la lógica de negocio.
 * 
 * Endpoints disponibles:
 * - /EquipoImagenologia/requestALL : Consulta todos los equipos.
 * - /EquipoImagenologia/addEquipo  : Agrega un nuevo equipo.
 * - /EquipoImagenologia/editEquipo : Edita un equipo existente.
 * 
 * @author Maria de Jesus Rebolledo Bustillo
 */
@RestController
@RequestMapping("/EquipoImagenologia")
public class EquipoImagenologiaController {
 
    /** Interfaz que permite aislar la implementación de la lógica de negocio 
     *  permitiendo un mayor desacoplamiento.
     */
    private final EquipoImagenologiaService service; 
    
    
    /**
     * Constructor del controlador que inyecta el servicio de equipos.
     * @param service instancia del EquipoImagenologiaService
     */
    public EquipoImagenologiaController(EquipoImagenologiaService service){
        this.service = service; 
    }
    
    
    
    /**
     * Endpoint para consultar todos los equipos de imagenología.Realiza una llamada al servicio {@link EquipoImagenologiaService#consultarTodos()}
 y retorna la lista de DTOs de equipos.
     *
     * @param token 
     * @return ResponseEntity con la lista de {@link EquipoImagenologiaDTO} (que Spring convierte a JSON)y código HTTP 200.
     */
    @GetMapping("/requestALL")
    public ResponseEntity<List<EquipoImagenologiaDTO>> consultarTodos(@CookieValue(value = "token", required = false) String token){
        System.out.println("Entró al controlador");
        List<EquipoImagenologiaDTO> datos = service.consultarTodos(token);
        return ResponseEntity.ok(datos);
    }
    
    
    /**
     * Endpoint para agregar un nuevo equipo de imagenología.
     * Recibe un JSON en el cuerpo de la petición con los datos necesarios para hacer un mapeo automático 
     * a un objeto {@link EquipoImagenologiaRequest} ,  lo envía al servicio EquipoImagenologiaService
     * y devuelve el DTO del equipo agregado.
     * 
     * @param equipoRequest objeto con los datos del equipo a agregar
     * @return ResponseEntity con el {@link EquipoImagenologiaDTO} del equipo agregado y código HTTP 200
     */
    @PostMapping("/addEquipo")
    public ResponseEntity<Object> addEquipo(@RequestBody EquipoImagenologiaRequest equipoRequest) {
        EquipoImagenologiaDTO equipoImgDTO = service.add(equipoRequest); 
        return ResponseEntity.ok(equipoImgDTO);
           
        }
    
    /**
     * Endpoint para editar un equipo existente.
     * Recibe un JSON en el cuerpo de la petición con los nuevos datos del equipo, esto se 
     * mapea automáticamente a un EquipoImagenologiaReques.
     * Se llama al servicio y retorna el resultado de la operación. 
     * 
     * Si el equipo no se pudo editar por alguna excepción no manejada, devuelve un ResponseEntity 
     * con código HTTP 409 (CONFLICT)y un mensaje de error.
     * Si la edición es exitosa, devuelve un ResponseEntity con código HTTP 200 y una lista
     * que contiene un indicador de éxito y el DTO actualizado.
     * 
     * @param equipoRequest objeto con los datos del equipo a editar
     * @return ResponseEntity con el resultado de la operación y código HTTP correspondiente
     */
    @PostMapping("/editEquipo")
    public ResponseEntity<Object> editEquipo(@RequestBody EquipoImagenologiaRequest equipoRequest) {
            EquipoImagenologiaDTO equipo = service.edit(equipoRequest);
            List<Object> equipos = new ArrayList();
            
            if (equipo == null) {
                equipos.add("0");
                equipos.add(null);
                 return ResponseEntity.status(HttpStatus.CONFLICT).body("El equipo no se pudo editar correctamente");
            } else {
                equipos.add("1");
                equipos.add(equipo);
                return ResponseEntity.ok(equipos); 
            }
        }
    
    /**
    * Consulta los equipos de imagenología en un área específica y devuelve una lista de los mismos.
    * Este método utiliza el valor del token almacenado en la cookie para consultar los equipos.
    * 
    * @param token El token de autenticación almacenado en la cookie. Si no está presente, puede ser nulo.
    * @return Un objeto `ResponseEntity` que contiene la lista de equipos de imagenología en el cuerpo de la respuesta.
    */
    @GetMapping("/consultaEquiposArea")
    public ResponseEntity<Object> consultaJefeServicio(@CookieValue(value = "token", required = false) String token){
        List<EquipoImagenologiaDTO> equiposDTO = service.consultarEquipoArea(token);
        System.out.println("los equipos son: " + equiposDTO);
       return ResponseEntity.ok(equiposDTO);
  
    }
  
}
