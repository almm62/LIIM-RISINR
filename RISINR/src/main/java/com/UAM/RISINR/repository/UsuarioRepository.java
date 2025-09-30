package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, UsuarioPK> {
    
    @Override
    List <Usuario> findAll();
    List <Usuario> findByAreaidArea(AreaDeServicio area);
    @Override
    Optional<Usuario> findById(UsuarioPK id);
    Optional<Usuario> findByCorreoElectronico(String correo);
    
    
}
