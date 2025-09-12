package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import com.UAM.RISINR.service.user.UserService;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/user")
public class UserController {
    
    private final UserService userService;
    
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/getAll")
    public ResponseEntity<List<UsuarioResumenDTO>> getAll(HttpServletRequest httpReq) {
        List<UsuarioResumenDTO> resp=userService.getAll();
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/create")
    public ResponseEntity<UsuarioResumenDTO> create(@RequestBody CrearUsuarioDTO dto,
                                                  HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        UsuarioResumenDTO resp=userService.create(dto, subjectJson);
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/update")
    public ResponseEntity<UsuarioResumenDTO> update(@RequestBody ActualizarUsuarioDTO dto,
                                                  HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        UsuarioResumenDTO resp=userService.update(dto, subjectJson);
        return ResponseEntity.ok(resp);
    }
}
