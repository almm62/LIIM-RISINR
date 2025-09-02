package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.DatosAcceso;
import com.UAM.RISINR.model.DatosAccesoPK;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DatosAccesoRepository extends JpaRepository <DatosAcceso, DatosAccesoPK>{
    @Override
    List <DatosAcceso> findAll();
    Optional<DatosAcceso> findByIdUsuarioID(String usuarioID);
}
