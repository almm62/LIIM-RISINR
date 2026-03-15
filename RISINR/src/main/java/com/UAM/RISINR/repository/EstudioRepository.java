package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Estudio;
import java.util.List;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con Estudio.
 * Proporciona métodos para consultar y administrar información de estudios médicos
 * de imagenología en el sistema.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface EstudioRepository extends JpaRepository<Estudio,Integer> {
    List<Estudio> findByAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea);
}
