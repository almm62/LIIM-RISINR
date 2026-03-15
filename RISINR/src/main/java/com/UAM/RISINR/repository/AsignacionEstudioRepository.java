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
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface AsignacionEstudioRepository extends JpaRepository<AsignacionEstudio,AsignacionEstudioPK>{
    /**
     * Busca asignaciones por lista de equipos de imagenología y lista de estudios.
     * @param equipoImagenologia Lista de equipos a filtrar
     * @param estudios Lista de estudios a filtrar
     * @return Lista de AsignacionEstudio que coinciden con ambos filtros
     */
    List<AsignacionEstudio> findByEquipoImagenologiaInAndEstudioIn(List<EquipoImagenologia> equipoImagenologia, List<Estudio> estudios);
    /**
     * Busca asignaciones por estudio y fecha de la llave primaria.
     * @param es Estudio a filtrar
     * @param fechapk Marca de tiempo epoch de la fecha de la asignación
     * @return Lista de AsignacionEstudio para el estudio y fecha indicados
     */
    List<AsignacionEstudio> findByEstudioAndAsignacionEstudioPK_FechaPk(Estudio es, long fechapk);
    /**
     * Busca todas las asignaciones para una lista de estudios.
     * @param estudios Lista de estudios a filtrar
     * @return Lista de AsignacionEstudio que pertenecen a alguno de los estudios indicados
     */
    List<AsignacionEstudio> findByEstudioIn(List<Estudio> estudios);
    /**
     * Busca asignaciones por equipo, fecha y estado para verificar disponibilidad.
     * @param equipoImagenologia Equipo de imagenología a consultar
     * @param fechaPk Fecha de la asignación en milisegundos epoch
     * @param estado Estado de la asignación (ej. "Activo")
     * @return Lista de AsignacionEstudio que coinciden con los tres criterios
     */
    List<AsignacionEstudio> findByEquipoImagenologiaAndAsignacionEstudioPK_FechaPkAndEstado(EquipoImagenologia equipoImagenologia,long fechaPk, String estado);
}