package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Paciente;
import com.UAM.RISINR.model.SolicitudDeEstudio;
import com.UAM.RISINR.model.SolicitudDeEstudioPK;
import java.util.List;

/**
 * Repositorio para la entidad SolicitudDeEstudio. Gestiona las solicitudes de estudios
 * médicos realizadas por los médicos, permitiendo consultas por estado y paciente.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface SolicitudDeEstudioRepository extends JpaRepository<SolicitudDeEstudio,SolicitudDeEstudioPK>{
    /**
     * Busca solicitudes de estudio por estado.
     * @param estado Estado a filtrar (ej. "SOLICITADO", "Cancelado consultorio")
     * @return Lista de SolicitudDeEstudio con el estado indicado
     */
    List<SolicitudDeEstudio> findByEstado(String estado);
    /**
     * Busca solicitudes de estudio por estado y lista de pacientes.
     * @param estado Estado a filtrar
     * @param paciente Lista de pacientes a filtrar
     * @return Lista de SolicitudDeEstudio que coinciden con el estado y pertenecen a alguno de los pacientes
     */
    List<SolicitudDeEstudio> findByEstadoAndPacienteIn(String estado, List<Paciente> paciente);
    @Override
    List<SolicitudDeEstudio> findAll();

}
