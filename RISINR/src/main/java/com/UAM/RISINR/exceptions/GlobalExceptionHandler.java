/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.exceptions;

import com.UAM.RISINR.repository.EventoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Clase encargada de manejar las excepciones globales en la aplicación.
 * Se utiliza para capturar errores específicos lanzados durante la ejecución
 * y devolver una respuesta HTTP adecuada al cliente.
 * 
 * Excepciones manejadas:
 * - ResourceNotFoundException
 * - ResourceFoundException
 * - IncompleteFormException
 * 
 * Cada excepción recibe el id del evento correspondiento para poder buscar y  
 * retornar la descripción asociada al evento correspondiente y un código HTTP específico.
 * 
 * Autor: Maria de Jesus Rebolledo Bustillo 
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    /** Repositorio de eventos utilizado para obtener la descripción asociada a cada excepción */
    private final EventoRepository eventoRepository;

    public GlobalExceptionHandler(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }
    
    /**
     * Maneja las excepciones de tipo ResourceNotFoundException.
     * Obtiene la descripción del evento asociado a la excepción y retorna
     * una respuesta HTTP con código 409 (CONFLICT) y el mensaje.
     * 
     * @param ex excepción de recurso no encontrado
     * @return ResponseEntity con mensaje del evento y código HTTP 409
     */
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<String> handleResourceNotFoundException(ResourceNotFoundException ex) {   
        String message = eventoRepository.findByIdEvento(ex.getidEvento()).getDescripcion();
        System.out.println(message);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(message);
    }
    
    /**
     * Maneja las excepciones de tipo ResourceFoundException.
     * Obtiene la descripción del evento asociado a la excepción y retorna
     * una respuesta HTTP con código 409 (CONFLICT) y el mensaje.
     * 
     * @param ex excepción de recurso ya existente
     * @return ResponseEntity con mensaje del evento y código HTTP 409
     */
    @ExceptionHandler(ResourceFoundException.class)
    public ResponseEntity<String> handleResourceFoundException(ResourceFoundException ex) {
        String message = eventoRepository.findByIdEvento(ex.getidEvento()).getDescripcion();
        System.out.println(message);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(message);
    }
    
    
     /**
     * Maneja las excepciones de tipo IncompleteFormException.
     * Obtiene la descripción del evento asociado a la excepción y retorna
     * una respuesta HTTP con código 400 (BAD_REQUEST) y el mensaje.
     * 
     * @param ex excepción de formulario con información incompleto
     * @return ResponseEntity con mensaje del evento y código HTTP 400
     */
    @ExceptionHandler(IncompleteFormException.class)
    public ResponseEntity<String> handleIncompleteFormException(IncompleteFormException ex) {
        String message = eventoRepository.findByIdEvento(ex.getidEvento()).getDescripcion();
        System.out.println(message);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(message);
    }
  
}
