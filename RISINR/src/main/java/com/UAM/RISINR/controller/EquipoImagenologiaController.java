/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.EquipoImagenologiaDTO;
import com.UAM.RISINR.service.equipoImagenologia.EquipoImagenologiaService;
import com.fasterxml.jackson.databind.node.ArrayNode;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author vsfs2
 */
@RestController
@RequestMapping("/EquipoImagenologia")
public class EquipoImagenologiaController {
 
    private final EquipoImagenologiaService service; 
    
    public EquipoImagenologiaController(EquipoImagenologiaService service){
        this.service = service; 
    
    }
    

    
    @PostMapping("/requestALL")
    public ResponseEntity<List<EquipoImagenologiaDTO>> consultarTodos(){
        System.out.println("Entró al controlador");
        List<EquipoImagenologiaDTO> datos = service.consultarTodos();
        System.out.println("Salio del service");
        return ResponseEntity.ok(datos);
    }
    
    @PostMapping("/addEquipo")
    public ResponseEntity<Object> addEquipo(@RequestBody EquipoImagenologiaDTO equipoDTO) {
        System.out.println("Entró al controlador para agreagar");
        EquipoImagenologiaDTO equipoImgDTO = service.add(equipoDTO); 
        System.out.println("Salio del service");
        return ResponseEntity.ok(equipoImgDTO);
           
        }
    
    
    @PostMapping("/editEquipo")
    public ResponseEntity<Object> editEquipo(@RequestParam Map<String, String> formData) {
            EquipoImagenologiaDTO equipo = service.edit(formData);
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
  
}
