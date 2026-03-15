package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AsignacionEstudio;
import com.UAM.RISINR.model.AsignacionEstudioPK;
import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.Estudio;

import java.util.List;


/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con AsignacionEstudio.
 * Proporciona métodos para consultar asignaciones de estudios médicos a equipos de imagenología
 * según diferentes criterios como equipo, estudio, fecha y estado.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface AsignacionEstudioRepository extends JpaRepository<AsignacionEstudio,AsignacionEstudioPK>{
    List<AsignacionEstudio> findByEquipoImagenologiaInAndEstudioIn(List<EquipoImagenologia> equipoImagenologia, List<Estudio> estudios);
    List<AsignacionEstudio> findByEstudioAndAsignacionEstudioPK_FechaPk(Estudio es, long fechapk);
    List<AsignacionEstudio> findByEstudioIn(List<Estudio> estudios);
    List<AsignacionEstudio> findByEquipoImagenologiaAndAsignacionEstudioPK_FechaPkAndEstado(EquipoImagenologia equipoImagenologia,long fechaPk, String estado);
}