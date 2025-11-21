package com.UAM.RISINR.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.UAM.RISINR.model.AsignacionEstudio;
import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;

import com.UAM.RISINR.service.citas.CitasService;

import jakarta.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/citas")
public class CitasController {
    
    private final CitasService citasService;

    public CitasController(CitasService citasService) {
        this.citasService = citasService;
    }
    
    @GetMapping("/getStudies")
    public ResponseEntity<List<EstudioDTO>> getStudies(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        List<EstudioDTO> resultados = citasService.getStudies(subjectJson);
        //Lista de Estudios
        return ResponseEntity.ok(resultados);
    }
    
    @GetMapping("/getSala")
    public ResponseEntity<List<SalaDTO>> getSala(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        List<SalaDTO> resultado = citasService.getSalas(subjectJson);

        return ResponseEntity.ok(resultado);
    }
    
    @GetMapping("/getAll")
    public ResponseEntity<List<CitaDTO>> getAll(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        List<CitaDTO> citas =citasService.getAll(subjectJson);
        return ResponseEntity.ok(citas);
    }
    
    @PostMapping("/CreateStudyControl")
    public ResponseEntity<CitaDTO> CreateStudyControl(HttpServletRequest httpReq, 
                                          @RequestBody AgendaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        CitaDTO cita = citasService.CreateStudyControl(subjectJson,dto);     
        //Cita recien creada
        return ResponseEntity.ok(cita);
    }

    @PostMapping("/CreateStudyAssignment")
    public ResponseEntity<AsignacionEstudioDTO> CreateStudyAssignment(HttpServletRequest httpReq, 
                                          @RequestBody AsignacionEstudioDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        AsignacionEstudioDTO resultado= citasService.CreateStudyAssignment(subjectJson,dto);
        return ResponseEntity.ok(resultado);
    }
    
    @PostMapping("/UpdateStudyControl")
    public ResponseEntity<CitaDTO> UpdateStudyControl(HttpServletRequest httpReq, 
                                          @RequestBody ReagendaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        CitaDTO cita = citasService.UpdateStudyControl(subjectJson, dto);

        //Cambio en cita existente (Fecha, sala, etc)
        return ResponseEntity.ok(cita);
    }

    
    @PostMapping("/cancel")
    public ResponseEntity<CitaDTO> cancel(HttpServletRequest httpReq, 
                                          @RequestBody CancelaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        // Creacion de registro con estado:CANCELADO de cita existente, NO ALTERAR REGISTRO EXISTENTE
        return ResponseEntity.ok().build();
    }

}