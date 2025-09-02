package com.UAM.RISINR.service.shared;
import com.UAM.RISINR.service.model.JwtSessionInfo;

public interface JwtService {
    /**
     * Emite un JWT. Serializamos un JSON
     * con los datos mínimos para reconstruir la SesionPK:
     * nme (numEmpleado), curp, asi (aplicacionId), hst (horaInicio).
     */
    String emitirToken(int numEmpleado,
                       String curp,
                       long horaInicio,
                       int aplicacionId);
    /**
     * Valida y decodifica el token. Extrae del 'subject' JSON los campos
     * necesarios para reconstruir la PK de Sesion (hst, nme, curp, asi).
     * Debe lanzar IllegalArgumentException si el token es inválido o no puede parsearse.
     */
    JwtSessionInfo parseToken(String tokenJWT);
    
}
