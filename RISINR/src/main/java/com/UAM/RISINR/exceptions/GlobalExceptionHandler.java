/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.exceptions;

import com.UAM.RISINR.model.Evento;
import com.UAM.RISINR.repository.EventoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 *
 * @author vsfs2
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    private final EventoRepository eventoRepository;

    public GlobalExceptionHandler(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<String> handleEquipoNotFound(ResourceNotFoundException ex) {
        
        
        return ResponseEntity.status(HttpStatus.CONFLICT).body(ex.getMessage());
    }
    
    @ExceptionHandler(ResourceFoundException.class)
    public ResponseEntity<String> handleResourceFoundException(ResourceFoundException ex) {
        
        String message = eventoRepository.findByIdEvento(ex.getidEvento()).getDescripcion();
        System.out.println(message);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(message);
    }
  
}
