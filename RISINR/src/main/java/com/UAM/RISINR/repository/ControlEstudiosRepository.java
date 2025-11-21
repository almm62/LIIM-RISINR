package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.ControlEstudios;
import com.UAM.RISINR.model.ControlEstudiosPK;
import com.UAM.RISINR.model.Estudio;

import java.util.List;


public interface ControlEstudiosRepository extends JpaRepository<ControlEstudios,ControlEstudiosPK>{
    List<ControlEstudios> findByEstudio(Estudio estudio);
    List<ControlEstudios> findByEstudioIn(List<Estudio> estudio);
    List<ControlEstudios> findByEstudioInAndEstadoInAndCerradoIsFalse(List<Estudio> estudio, List<String> estado);
}
