package com.UAM.RISINR.service.shared;
import com.UAM.RISINR.service.model.JwtSessionInfo;

/**
 * Interfaz del servicio JWT. Define los contratos para emitir y parsear tokens
 * JWT utilizados en la autenticación y gestión de sesiones del sistema.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface JwtService {
    /**
     * Emite un JWT con los datos mínimos de sesión en el subject (nme, curp, asi, hst).
     * @param numEmpleado Número de empleado del usuario (parte de la PK de Sesion)
     * @param curp CURP del usuario (parte de la PK de Sesion)
     * @param horaInicio Marca de tiempo epoch en milisegundos del inicio de sesión
     * @param aplicacionId Identificador de la aplicación que inicia la sesión
     * @return Token JWT firmado con RS256
     */
    String emitirToken(int numEmpleado,
                       String curp,
                       long horaInicio,
                       int aplicacionId);
    /**
     * Valida y decodifica el token JWT, extrayendo los datos de sesión del subject.
     * @param tokenJWT Token JWT a validar y parsear
     * @return JwtSessionInfo con los campos nme, curp, hst y asi reconstruidos
     */
    JwtSessionInfo parseToken(String tokenJWT);
    
}
