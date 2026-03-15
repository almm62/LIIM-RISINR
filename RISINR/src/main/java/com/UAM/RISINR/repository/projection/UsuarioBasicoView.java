package com.UAM.RISINR.repository.projection;

/**
 * Proyección para consultas básicas de usuario. Expone el identificador único,
 * número de empleado y CURP del usuario.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface UsuarioBasicoView {
    /** @return Identificador de acceso del usuario. */
    String getUsuarioId();
    /** @return Número de empleado del usuario. */
    int getNumEmpleado();
    /** @return CURP del usuario. */
    String getCurp();
}
