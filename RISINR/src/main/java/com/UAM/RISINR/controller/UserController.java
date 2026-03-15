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


/**
 * Controlador REST para gestionar operaciones relacionadas con Gestion de Usuarios.
 * Proporciona endpoints para crear, actualizar, listar usuarios.
 * Incluye endpoints para que cada usuario pueda cambiar su 
 * correo electrónico y contraseña.
 * Todos los endpoints requieren autenticación mediante token JWT.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
@RestController
@RequestMapping("/user")
public class UserController {
    
    private final UserService userService;
    
    /**
     * Constructor del controlador.
     * 
     * @param userService servicio que contiene la lógica de negocio para usuarios
     */
    public UserController(UserService userService) {
        this.userService = userService;
    }
     
    /**
     * Endpoint para obtener la lista de todos los usuarios del sistema.
     * Cuando se accede con perfil de Jefe de Servicio, filtra por Area de servicio.
     * Retorna información resumida de cada usuario.
     * Requiere autenticación válida.
     * 
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con lista de {@link UsuarioResumenDTO} y código HTTP 200 si es exitoso,
     *         o código HTTP 401 si no está autenticado
     */
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

    /**
     * Endpoint para crear un nuevo usuario en el sistema.
     * Recibe los datos del usuario a crear y retorna la información del usuario creado.
     * Requiere autenticación válida y permisos adecuados.
     * 
     * @param dto objeto {@link CrearUsuarioDTO} con los datos del nuevo usuario
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con {@link UsuarioResumenDTO} del usuario creado y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
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

    /**
     * Endpoint para actualizar la información de un usuario existente.
     * Permite modificar datos del usuario como nombre, roles, estado, etc.
     * Requiere autenticación válida y permisos adecuados.
     * 
     * @param dto objeto {@link ActualizarUsuarioDTO} con los datos actualizados del usuario
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con {@link UsuarioResumenDTO} del usuario actualizado y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
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

    /**
     * Endpoint para cambiar la contraseña de un usuario.
     * Permite al usuario cambiar su propia contraseña.
     * Requiere autenticación válida.
     * 
     * @param dto objeto {@link ChangePswdDTO} con la contraseña actual y la nueva contraseña
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con mensaje de confirmación y código HTTP 200 si es exitoso,
     *         o código HTTP 401 si no está autenticado
     */
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

    /**
     * Endpoint para cambiar el correo electrónico del usuario con la sesión activa.
     * Requiere autenticación válida.
     * 
     * @param dto objeto {@link ChangeMailDTO} con el nuevo correo electrónico
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con mensaje de confirmación y código HTTP 200 si es exitoso,
     *         o código HTTP 401 si no está autenticado
     */
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

    /**
     * Endpoint para obtener la información del usuario actualmente en sesión.
     * Retorna los datos del usuario autenticado basándose en el token JWT.
     * Útil para mostrar información del perfil del usuario logueado.
     * 
     * @param httpReq solicitud HTTP para validar autenticación
     * @return ResponseEntity con {@link UsuarioResumenDTO} del usuario en sesión y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
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
