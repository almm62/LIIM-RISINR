package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Sesion;
import com.UAM.RISINR.model.SesionPK;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repositorio para la entidad Sesion. Gestiona las sesiones activas de los usuarios
 * en el sistema, identificadas mediante la llave compuesta SesionPK.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface SesionRepository extends JpaRepository<Sesion, SesionPK> { }
