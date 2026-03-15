package com.UAM.RISINR.controller;

import com.UAM.RISINR.service.shared.InitialService;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controlador REST para la obtención de datos iniciales del sistema. Expone
 * los endpoints para consultar las áreas de servicio y roles disponibles,
 * utilizados al cargar la interfaz de usuario.
 * @author Pedro Misael Rodríguez Jiménez
 */
@RestController
@RequestMapping("/initial")
public class InitialController {
    
    private final InitialService initialService;
    
    /**
     * Constructor con inyección del servicio de datos iniciales.
     * @param initialService Servicio que provee áreas y roles del sistema
     */
    public InitialController(InitialService initialService){
        this.initialService=initialService;
    }

    /**
     * Retorna la lista de áreas de servicio disponibles serializadas como JSON.
     * @param httpReq Solicitud HTTP entrante
     * @return ResponseEntity con la lista de áreas como cadenas JSON y código HTTP 200
     */
    @GetMapping("/getAreas")
    public ResponseEntity<List<String>> getAreas(HttpServletRequest httpReq){
        List<String> resp = initialService.getAreas();
        return ResponseEntity.ok(resp);
    }

    /**
     * Retorna la lista de roles disponibles en el sistema serializados como JSON.
     * @param httpReq Solicitud HTTP entrante
     * @return ResponseEntity con la lista de roles como cadenas JSON y código HTTP 200
     */
    @GetMapping("/getRoles")
    public ResponseEntity<List<String>> getRoles(HttpServletRequest httpReq){
        List<String> resp= initialService.getRoles();
        return ResponseEntity.ok(resp);
    }
}
