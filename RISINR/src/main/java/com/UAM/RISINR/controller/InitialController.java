package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.dto.shared.AreaDTO;
import com.UAM.RISINR.model.dto.shared.RolDTO;
import com.UAM.RISINR.service.shared.InitialService;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/initial")
public class InitialController {
    
    private final InitialService initialService;
    
    public InitialController(InitialService initialService){
        this.initialService=initialService;
    }
    
    @GetMapping("/getAreas")
    public ResponseEntity<List<String>> getAreas(HttpServletRequest httpReq){
        List<String> resp = initialService.getAreas();
        return ResponseEntity.ok(resp);
    }
    
    @GetMapping("/getRoles")
    public ResponseEntity<List<String>> getRoles(HttpServletRequest httpReq){
        List<String> resp= initialService.getRoles();
        return ResponseEntity.ok(resp);
    }
}
