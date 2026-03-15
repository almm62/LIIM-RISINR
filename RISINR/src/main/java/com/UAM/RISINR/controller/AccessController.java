package com.UAM.RISINR.controller;

import com.UAM.RISINR.model.dto.access.LoginRequestDTO;
import com.UAM.RISINR.model.dto.access.LoginResponseDTO;
import com.UAM.RISINR.model.dto.access.SelectRolRequestDTO;
import com.UAM.RISINR.service.access.AccessService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controlador REST para gestionar operaciones de acceso y autenticación.
 * Proporciona endpoints para login, selección de rol y logout.
 * Utiliza cookies HTTP para almacenar tokens JWT.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
@RestController
@RequestMapping("/access")
public class AccessController {

    private final AccessService accessService;

    /**
     * Constructor del controlador.
     * 
     * @param accessService servicio que contiene la lógica de negocio para acceso
     */
    public AccessController(AccessService accessService) {
        this.accessService = accessService;
    }

    /**
     * Endpoint para iniciar sesión en el sistema.
     * Recibe credenciales del usuario y retorna información de sesión junto con token JWT.
     * El token se almacena en una cookie HTTP para uso posterior.
     * 
     * @param request objeto {@link LoginRequestDTO} con las credenciales del usuario
     * @param httpReq solicitud HTTP para extraer la dirección IP del cliente
     * @return ResponseEntity con {@link LoginResponseDTO} que incluye token JWT y datos del usuario,
     *         código HTTP 200 y cookie con el token
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO request,
                                                  HttpServletRequest httpReq) {

        String ip = extraerIp(httpReq);
        LoginResponseDTO resp = accessService.login(request, ip);
        if (resp.getTokenJWT() != null){
            ResponseCookie cookie = ResponseCookie.from("token", resp.getTokenJWT())
            .httpOnly(false)   
            .secure(false)   
            .path("/")
            .sameSite("Lax")
            .build();
            
            return ResponseEntity
                .ok()
                .header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(resp);
        }
        return ResponseEntity.ok(resp);
    }

    /**
     * Endpoint para seleccionar un rol específico después del login.
     * Permite a usuarios con múltiples roles elegir con cuál trabajar.
     * Genera un nuevo token JWT con el rol seleccionado.
     * 
     * @param request objeto {@link SelectRolRequestDTO} con el rol seleccionado
     * @param httpReq solicitud HTTP para extraer la dirección IP del cliente
     * @return ResponseEntity con {@link LoginResponseDTO} actualizado con el nuevo token JWT,
     *         código HTTP 200 y cookie actualizada
     */
    @PostMapping("/seleccionar-rol")
    public ResponseEntity<LoginResponseDTO> seleccionarRol(@RequestBody SelectRolRequestDTO request,
                                                           HttpServletRequest httpReq) {

        String ip = extraerIp(httpReq);
        LoginResponseDTO resp = accessService.seleccionarRol(request, ip);
        ResponseCookie cookie = ResponseCookie.from("token", resp.getTokenJWT())
            .httpOnly(false)           
            .secure(false)          
            .path("/")
            .sameSite("Lax")
            .build();
        return ResponseEntity
                .ok()
                .header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(resp);
    }

    /**
     * Endpoint para cerrar sesión del usuario.
     * Invalida el token JWT actual y elimina la cookie de autenticación.
     * Registra el tipo de cierre de sesión para auditoría.
     * 
     * @param tipoCierre tipo de cierre de sesión (normal, timeout, forzado, etc.)
     * @return ResponseEntity con código HTTP 204 (No Content) si el logout fue exitoso,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestParam("tipoCierre") String tipoCierre) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        accessService.logout(subjectJson, tipoCierre);

        ResponseCookie delete = ResponseCookie.from("token","").maxAge(0).path("/").sameSite("Lax").build();
        return ResponseEntity.noContent()
                .header(HttpHeaders.SET_COOKIE, delete.toString())
                .build();
    }

    /**
     * Método auxiliar para extraer la dirección IP del cliente.
     * Intenta obtener la IP real del cliente considerando proxies y balanceadores de carga.
     * Busca en orden: X-Forwarded-For, X-Real-IP, y finalmente remoteAddr.
     * 
     * @param req solicitud HTTP de la que se extraerá la IP
     * @return String con la dirección IP del cliente
     */
    private String extraerIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip != null && !ip.isBlank()) {
            int coma = ip.indexOf(',');
            return (coma > 0 ? ip.substring(0, coma) : ip).trim();
        }
        ip = req.getHeader("X-Real-IP");
        if (ip != null && !ip.isBlank()) return ip.trim();
        return req.getRemoteAddr();
    }
}
