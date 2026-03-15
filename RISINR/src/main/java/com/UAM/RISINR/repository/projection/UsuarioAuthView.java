package com.UAM.RISINR.repository.projection;

/**
 * Proyección para consultas de autenticación de usuario. Expone los datos personales
 * necesarios para construir el contexto de seguridad: nombre, apellidos, área,
 * número de empleado y CURP.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface UsuarioAuthView {
    /** @return Nombre del usuario. */
    String getNombre();
    /** @return Apellido paterno del usuario. */
    String getApellidoPaterno();
    /** @return Apellido materno del usuario. */
    String getApellidoMaterno();
    /** @return Identificador del área de servicio asignada al usuario. */
    Integer getAreaId();
    /** @return Número de empleado del usuario. */
    int getNumEmpleado();
    /** @return CURP del usuario. */
    String getCurp();
}
