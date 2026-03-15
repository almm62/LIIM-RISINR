package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Equipo;
import java.util.List;

/**
 * Repositorio para la entidad Equipo. Gestiona los equipos registrados en el sistema
 * y permite consultar equipos filtrados por área de servicio.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface EquipoRepository extends JpaRepository<Equipo,String>{
    /**
     * Busca equipos registrados en el área de servicio indicada.
     * @param areaDeServicioidArea Área de servicio por la que filtrar
     * @return Lista de Equipo pertenecientes al área indicada
     */
    List<Equipo> findByAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea);
}
