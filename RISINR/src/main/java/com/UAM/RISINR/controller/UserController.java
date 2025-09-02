package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import com.UAM.RISINR.service.user.UserService;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;
import org.springframework.http.ResponseEntity;
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
        String ip = extraerIp(httpReq);
        UsuarioResumenDTO resp=userService.create(dto, ip);
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/update")
    public ResponseEntity<Void> update(@RequestBody ActualizarUsuarioDTO dto,
                                                  HttpServletRequest httpReq) {
        String ip = extraerIp(httpReq);
        userService.update(dto, ip);
        return ResponseEntity.noContent().build();
    }
    
    /** Extrae la primera IP válida (X-Forwarded-For o remoteAddr) y la acorta a 15 chars. */
    private String extraerIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip != null && !ip.isBlank()) {
            int coma = ip.indexOf(',');
            return (coma > 0 ? ip.substring(0, coma) : ip).trim(); // sin truncar
        }
        ip = req.getHeader("X-Real-IP");
        if (ip != null && !ip.isBlank()) return ip.trim();
        return req.getRemoteAddr();
    }
}
