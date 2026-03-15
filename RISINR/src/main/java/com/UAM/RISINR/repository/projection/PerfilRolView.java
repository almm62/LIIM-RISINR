package com.UAM.RISINR.repository.projection;

/**
 * Proyección para consultas sobre la relación Perfil-Rol. Expone el identificador
 * del rol dentro de la llave compuesta de Perfil y el estado de la asignación.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface PerfilRolView {
    /** @return Identificador del rol dentro de la llave compuesta de Perfil. */
    int getPerfilPKRolidRol();
    /** @return Estado de la asignación de perfil. */
    int getEstado();
}
