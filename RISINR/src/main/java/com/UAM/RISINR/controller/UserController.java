package com.UAM.RISINR.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.ChangePswdDTO;
import com.UAM.RISINR.model.dto.userManager.ChangeMailDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import com.UAM.RISINR.service.user.UserService;

import jakarta.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/user")
public class UserController {
    
    private final UserService userService;
    
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/getAll")
    public ResponseEntity<List<UsuarioResumenDTO>> getAll(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        List<UsuarioResumenDTO> resp=userService.getAll(subjectJson);
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

    @PostMapping("/pswd")
    public ResponseEntity<Map<String,String>> changePswd(@RequestBody ChangePswdDTO dto,
                            HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        userService.changePswd(dto, subjectJson);
        return ResponseEntity.ok(Map.of("message", "Constraseña actualizada exitosamente"));
    }

    @PostMapping("/email")
    public ResponseEntity<Map<String,String>> changeMail(@RequestBody ChangeMailDTO dto,
                            HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        userService.changeMail(dto, subjectJson);
        return ResponseEntity.ok(Map.of("message", "Correo actualizado exitosamente"));
    }

    @GetMapping("/userSesion")
    public ResponseEntity<UsuarioResumenDTO> getUserSesion(HttpServletRequest httpReq){
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        UsuarioResumenDTO data = userService.getUserSesion(subjectJson);
        return ResponseEntity.ok(data);
    }
}
