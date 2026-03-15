package com.UAM.RISINR.service.shared.implementations;

import com.UAM.RISINR.security.Cybersecurity;
import com.UAM.RISINR.service.shared.JwtService;
import com.UAM.RISINR.service.model.JwtSessionInfo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Implementación del servicio JWT. Utiliza la clase Cybersecurity con firma RS256
 * para emitir tokens que contienen los datos de sesión en el subject, y los parsea
 * de vuelta a un objeto JwtSessionInfo.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Service
public class JwtServiceAdapter implements JwtService {

    private final Cybersecurity cybersecurity;
    private final ObjectMapper objectMapper;

    /**
     * Constructor con inyección de las dependencias de seguridad y serialización.
     * @param cybersecurity Componente de firma y validación RS256
     * @param objectMapper Mapper para serialización del subject JWT
     */
    public JwtServiceAdapter(Cybersecurity cybersecurity, ObjectMapper objectMapper) {
        this.cybersecurity = cybersecurity;
        this.objectMapper = objectMapper;
    }

    /**
     * Emite un JWT con los datos mínimos de sesión en el subject (nme, curp, asi, hst).
     * @param numEmpleado Número de empleado del usuario (parte de la PK de Sesion)
     * @param curp CURP del usuario (parte de la PK de Sesion)
     * @param horaInicio Marca de tiempo epoch en milisegundos del inicio de sesión
     * @param aplicacionId Identificador de la aplicación que inicia la sesión
     * @return Token JWT firmado con RS256
     */
    @Override
    public String emitirToken(int numEmpleado,
                              String curp,
                              long horaInicio,
                              int aplicacionId) {
        try {
            // Empaquetamos los datos en un JSON que irá en el 'subject' del JWT
            Map<String, Object> subject = new HashMap<>();
            subject.put("nme", numEmpleado); // PK usuario
            subject.put("curp", curp);       // PK usuario
            subject.put("asi", aplicacionId);// parte de SesionPK
            subject.put("hst", horaInicio);  // parte de SesionPK

            String jsonSubject = objectMapper.writeValueAsString(subject);

            // Cybersecurity firma RS256 y fija expiración internamente
            return cybersecurity.encriptarDatos(jsonSubject);
        } catch (JsonProcessingException e) {
            throw new IllegalStateException("No se pudo serializar el subject del JWT", e);
        }
    }
    
    /**
     * Valida y decodifica el token JWT, extrayendo los datos de sesión del subject.
     * @param tokenJWT Token JWT a validar y parsear
     * @return JwtSessionInfo con los campos nme, curp, hst y asi reconstruidos
     */
    @Override
    public JwtSessionInfo parseToken(String tokenJWT) {
        try {
            // Validación y lectura de claims usando la clase de seguridad
            String publicKeyPem = cybersecurity.getLlavePublica();
            Claims claims = cybersecurity.desencriptarDatos(publicKeyPem, tokenJWT);
            String subjectJson = claims.getSubject();

            // El subject es el JSON que emitimos con nme/curp/asi/hst
            Map<?, ?> map = objectMapper.readValue(subjectJson, Map.class);

            int nme = toInt(map.get("nme"));
            String curp = String.valueOf(map.get("curp"));
            int asi = toInt(map.get("asi"));
            long hst = toLong(map.get("hst"));

            return new JwtSessionInfo(nme, curp, hst, asi);
        } catch (Exception e) {
            throw new IllegalArgumentException("Token inválido o no parseable", e);
        }
    }

    private int toInt(Object o) {
        if (o instanceof Number) return ((Number) o).intValue();
        return Integer.parseInt(String.valueOf(o));
    }

    private long toLong(Object o) {
        if (o instanceof Number) return ((Number) o).longValue();
        return Long.parseLong(String.valueOf(o));
    }
}
