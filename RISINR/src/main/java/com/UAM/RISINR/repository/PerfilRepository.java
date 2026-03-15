package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Perfil;
import com.UAM.RISINR.model.PerfilPK;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Perfil.
 * Proporciona métodos para consultar y administrar información de perfiles de usuario
 * en el sistema, incluyendo búsquedas por número de empleado y CURP.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface PerfilRepository extends JpaRepository<Perfil, PerfilPK> {
    /**
     * Busca los perfiles asignados a un usuario identificado por número de empleado y CURP.
     * @param usuarioNumEmpleado Número de empleado del usuario
     * @param usuarioCurp CURP del usuario
     * @return Lista de Perfil asignados al usuario indicado
     */
    List<Perfil> findByPerfilPKUsuarioNumEmpleadoAndPerfilPKUsuarioCURP(
        int usuarioNumEmpleado,
        String usuarioCurp
    );
}
