package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Medico;
import com.UAM.RISINR.model.MedicoPK;

/**
 * Repositorio para la entidad Medico. Gestiona la información de los médicos
 * registrados en el sistema, identificados mediante la llave compuesta MedicoPK.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface MedicoRepository extends JpaRepository<Medico, MedicoPK> {

}
