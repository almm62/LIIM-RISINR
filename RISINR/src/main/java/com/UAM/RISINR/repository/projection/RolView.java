package com.UAM.RISINR.repository.projection;

/**
 * Proyección para consultas sobre la entidad Rol. Expone el identificador,
 * nombre y descripción de los roles disponibles en el sistema.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface RolView {
    /** @return Identificador único del rol. */
    Integer getIdRol();
    /** @return Nombre del rol. */
    String getNombre();
    /** @return Descripción del rol. */
    String getDescripcion();
}
