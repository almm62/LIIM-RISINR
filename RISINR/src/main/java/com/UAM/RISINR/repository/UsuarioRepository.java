package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Usuario.
 * Proporciona métodos para consultar y administrar información de usuarios
 * en el sistema, incluyendo búsquedas por área de servicio, identificador compuesto
 * y correo electrónico.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, UsuarioPK> {

    @Override
    List <Usuario> findAll();
    /**
     * Busca usuarios pertenecientes al área de servicio indicada.
     * @param area Área de servicio por la que filtrar
     * @return Lista de Usuario del área indicada
     */
    List <Usuario> findByAreaidArea(AreaDeServicio area);
    @Override
    Optional<Usuario> findById(UsuarioPK id);
    /**
     * Busca un usuario por su dirección de correo electrónico.
     * @param correo Dirección de correo electrónico a buscar
     * @return Optional con el Usuario si el correo existe en el sistema
     */
    Optional<Usuario> findByCorreoElectronico(String correo);
    
    
}
