package com.UAM.RISINR.security.jwt;

import com.UAM.RISINR.security.Cybersecurity;
import com.UAM.RISINR.service.access.AccessService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import org.springframework.http.ResponseCookie;

/**
 * Filtra cada request una sola vez.
 * - Si encuentra "Authorization: Bearer "token" " intenta validar la firma y la expiración.
 * - Si es válido, coloca un Authentication en el SecurityContext.
 * - Si es inválido o no existe, deja la cadena sin autenticar; las reglas de Security decidirán (401).
 *  Es un filtro de Spring que corre una vez por request. Aquí ocurren la extracción y el parseo/validación del JWT antes de entrar a tus controladores.
 */
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final Logger log = LoggerFactory.getLogger(JwtAuthenticationFilter.class);

    private final Cybersecurity cybersecurity;
    private final String publicKeyPem;
    private final AccessService accessService;

    public JwtAuthenticationFilter(Cybersecurity cybersecurity, AccessService accessService) {
        this.cybersecurity = cybersecurity;
        this.publicKeyPem = cybersecurity.getLlavePublica();
        this.accessService = accessService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain)
            throws ServletException, IOException {

        String uri = request.getRequestURI();

        // Rutas donde NO renovamos (evita doble Set-Cookie)
        boolean skipRenew = "OPTIONS".equalsIgnoreCase(request.getMethod())
                || uri.startsWith("/RISSERVER/vistas/")
                || uri.startsWith("/RISFSM/")
                || uri.equals("/RISSERVER/access/logout");

        // 1) Intentar por header
        String token = null;
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
        }

        // 2) Si no hay header, intentar cookie
        if (token == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("token".equals(c.getName()) && c.getValue() != null && !c.getValue().isBlank()) {
                        token = c.getValue();
                        break;
                    }
                }
            }
        }

        if (token != null) {
            try {
                // 3) Validación normal
                Claims claims = cybersecurity.desencriptarDatos(publicKeyPem, token);
                String subjectJson = claims.getSubject();

                // Autenticar
                var auth = new UsernamePasswordAuthenticationToken(
                        subjectJson, null, java.util.Collections.emptyList());
                SecurityContextHolder.getContext().setAuthentication(auth);

                // Renovar SIEMPRE (menos en skipRenew)
                if (!skipRenew) {
                    String nuevo = cybersecurity.encriptarDatos(subjectJson);
                    ResponseCookie refresh = ResponseCookie.from("token", nuevo)
                        .httpOnly(true)           
                        .secure(false)            
                        .path("/")
                        .sameSite("Lax")
                        .build();
                    response.addHeader(HttpHeaders.SET_COOKIE, refresh.toString());
                }

            } catch (ExpiredJwtException eje) {
                // 4) TOKEN EXPIRADO -> cerrar sesión por inactividad y borrar cookie
                try {
                    String subjectJson = eje.getClaims().getSubject(); // sujeto original
                    accessService.logout(subjectJson, "Inactividad");
                } catch (Exception e2) {
                    log.debug("No se pudo cerrar sesión por inactividad: {}", e2.getMessage());
                }

                ResponseCookie delete = ResponseCookie.from("token", "")
                        .maxAge(0).path("/").sameSite("Lax").build();
                response.addHeader(HttpHeaders.SET_COOKIE, delete.toString());
                // No autenticamos → el endpoint responderá 401/403 (esperado)

            } catch (Exception e) {
                // Firma inválida u otros errores → no autenticamos
                log.debug("JWT inválido: {}", e.getMessage());
            }
        }

        chain.doFilter(request, response);
    }
}