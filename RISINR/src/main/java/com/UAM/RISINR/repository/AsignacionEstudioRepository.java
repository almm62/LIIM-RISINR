package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AsignacionEstudio;
import com.UAM.RISINR.model.AsignacionEstudioPK;
import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.Estudio;

import java.util.List;


public interface AsignacionEstudioRepository extends JpaRepository<AsignacionEstudio,AsignacionEstudioPK>{
    List<AsignacionEstudio> findByEquipoImagenologiaInAndEstudioIn(List<EquipoImagenologia> equipoImagenologia, List<Estudio> estudios);
    List<AsignacionEstudio> findByEstudioAndAsignacionEstudioPK_FechaPk(Estudio es, long fechapk);
    List<AsignacionEstudio> findByEstudioIn(List<Estudio> estudios);
}