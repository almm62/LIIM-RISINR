package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.ControlEstudios;
import com.UAM.RISINR.model.ControlEstudiosPK;
import com.UAM.RISINR.model.Estudio;
import com.UAM.RISINR.model.Medico;
import com.UAM.RISINR.model.Paciente;

import java.util.List;

/**
 * Repositorio para la entidad ControlEstudios. Permite consultar y gestionar
 * los registros de control de estudios médicos, filtrando por estudio, estado,
 * paciente, médico y fecha.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface ControlEstudiosRepository extends JpaRepository<ControlEstudios,ControlEstudiosPK>{
    /**
     * Busca controles de estudio por estudio.
     * @param estudio Estudio a filtrar
     * @return Lista de ControlEstudios para el estudio indicado
     */
    List<ControlEstudios> findByEstudio(Estudio estudio);
    /**
     * Busca controles de estudio por lista de estudios.
     * @param estudio Lista de estudios a filtrar
     * @return Lista de ControlEstudios que pertenecen a alguno de los estudios indicados
     */
    List<ControlEstudios> findByEstudioIn(List<Estudio> estudio);
    /**
     * Busca controles activos (no cerrados) por lista de estudios y lista de estados.
     * @param estudio Lista de estudios a filtrar
     * @param estado Lista de estados válidos (ej. "Programado", "Reprogramado")
     * @return Lista de ControlEstudios no cerrados que coinciden con los filtros
     */
    List<ControlEstudios> findByEstudioInAndEstadoInAndCerradoIsFalse(List<Estudio> estudio, List<String> estado);
    /**
     * Busca controles activos filtrando además por lista de pacientes.
     * @param estudio Lista de estudios a filtrar
     * @param estado Lista de estados válidos
     * @param pacientes Lista de pacientes a filtrar
     * @return Lista de ControlEstudios no cerrados que coinciden con los tres filtros
     */
    List<ControlEstudios> findByEstudioInAndEstadoInAndPacienteInAndCerradoIsFalse(List<Estudio> estudio, List<String> estado, List<Paciente> pacientes);
    /**
     * Busca controles por fecha, médico, paciente, excluyendo un estado.
     * @param fechacontrolpk Fecha de la cita en milisegundos epoch
     * @param medico Médico asociado al control
     * @param paciente Paciente asociado al control
     * @param estado Estado a excluir de los resultados (ej. "Cancelado")
     * @return Lista de ControlEstudios que cumplen los criterios excluyendo el estado indicado
     */
    List<ControlEstudios> findByControlEstudiosPK_FechaControlPkAndMedicoAndPacienteAndEstadoNot(long fechacontrolpk, Medico medico, Paciente paciente, String estado);
}
