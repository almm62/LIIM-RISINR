package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Equipo;
import java.util.List;


public interface EquipoRepository extends JpaRepository<Equipo,String>{
    List<Equipo> findByAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea);
}
