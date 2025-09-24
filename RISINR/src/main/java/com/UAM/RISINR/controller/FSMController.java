package com.UAM.RISINR.controller;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping({"/rest/RISFSM", "/RISFSM"}) // <-- ambas bases
public class FSMController {

    @GetMapping(value = "/fsm2/{perfil}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Resource> getFSM2(@PathVariable String perfil) {
        String path = switch (perfil) {
            case "General"       -> "FSM/General.json";
            case "Admin"         -> "FSM/Admin.json";
            case "Recepcionista" -> "FSM/Admin.json";
            case "JefedelServicio" -> "FSM/JefeDeServicio.json";
            default              -> "FSM/General.json";
        };
        Resource resource = new ClassPathResource(path);
        if (!resource.exists()) return ResponseEntity.notFound().build();
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(resource);
    }
}