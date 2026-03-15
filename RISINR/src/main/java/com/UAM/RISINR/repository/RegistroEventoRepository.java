package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.RegistroEvento;
import com.UAM.RISINR.model.RegistroEventoPK;
import com.UAM.RISINR.repository.projection.DatosJson;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repositorio JPA para gestionar operaciones de base de datos relacionadas con RegistroEvento.
 * Proporciona métodos para consultar y administrar información de eventos registrados
 * en el sistema, incluyendo búsquedas por identificador de evento y tiempo de ocurrencia.
 * Extiende JpaRepository para heredar operaciones CRUD básicas.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
@Repository
public interface RegistroEventoRepository extends JpaRepository <RegistroEvento, RegistroEventoPK>{
    List<DatosJson> findByIdEventoIdAndIdHoraEventoGreaterThanEqual(Integer eventoIdEvento, Long umbralBloqueo);
}
