package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.DatosAcceso;
import com.UAM.RISINR.model.DatosAccesoPK;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con DatosAcceso.
 * DatosAcceso Almacena las credenciales de los Usuarios dados de alta.
 * Proporciona métodos para consultar y administrar los datos de acceso de usuarios
 * al sistema, incluyendo credenciales y tokens de autenticación.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Repository
public interface DatosAccesoRepository extends JpaRepository <DatosAcceso, DatosAccesoPK>{
    @Override
    List <DatosAcceso> findAll();
    /**
     * Busca las credenciales de acceso por identificador de usuario.
     * @param usuarioID Identificador único de acceso del usuario
     * @return Optional con los DatosAcceso si el identificador existe
     */
    Optional<DatosAcceso> findByIdUsuarioID(String usuarioID);
}
