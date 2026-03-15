package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Rol;
import com.UAM.RISINR.repository.projection.RolView;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Rol.
 * Proporciona métodos para consultar y administrar información de roles de usuario
 * disponibles en el sistema, incluyendo búsquedas por identificadores múltiples.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface RolRepository extends JpaRepository<Rol, Integer> {
    /**
     * Busca roles por una colección de identificadores.
     * @param ids Colección de identificadores de rol a consultar
     * @return Lista de proyecciones RolView con los roles encontrados
     */
    List<RolView> findByIdRolIn(Collection<Integer> ids);
}
