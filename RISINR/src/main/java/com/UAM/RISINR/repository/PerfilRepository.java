package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Perfil;
import com.UAM.RISINR.model.PerfilPK;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PerfilRepository extends JpaRepository<Perfil, PerfilPK> {
    List<Perfil> findByPerfilPKUsuarioNumEmpleadoAndPerfilPKUsuarioCURP(
        int usuarioNumEmpleado,
        String usuarioCurp
    );
}
