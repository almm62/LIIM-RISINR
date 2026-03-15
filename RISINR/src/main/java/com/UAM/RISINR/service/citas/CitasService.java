package com.UAM.RISINR.service.citas;

import java.util.List;

import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.FiltroDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;
import com.UAM.RISINR.model.dto.citas.SolicitudDeEstudioDTO;

/**
 * Interfaz del servicio de gestión de citas. Define los contratos para consultar
 * estudios y salas disponibles, así como para agendar, reagendar, cancelar y
 * asignar estudios a equipos de imagenología. También permite consultar las
 * órdenes de estudio pendientes.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface CitasService {
    /**
     * Retorna la lista de estudios disponibles en el área del usuario autenticado.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return Lista de EstudioDTO con los estudios del área
     */
    List<EstudioDTO> getStudies (String token);
    /**
     * Retorna la lista de salas disponibles en el área del usuario autenticado.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return Lista de SalaDTO con las ubicaciones de equipos del área
     */
    List<SalaDTO> getSalas (String token);
    /**
     * Retorna todas las citas activas del área aplicando los filtros indicados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Filtros de búsqueda (nombre y/o apellido del paciente)
     * @return Lista de CitaDTO con los controles de estudio que coinciden con los filtros
     */
    List<CitaDTO> getAll (String token, FiltroDTO dto);
    /**
     * Agenda una nueva cita creando un registro de ControlEstudio.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la cita a agendar
     * @return CitaDTO con la información del control de estudio creado
     */
    CitaDTO CreateStudyControl (String token, AgendaCitaDTO dto);
    /**
     * Crea una asignación de estudio vinculando un equipo de imagenología a un estudio y fecha.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la asignación a crear
     * @return AsignacionEstudioDTO con los datos de la asignación registrada
     */
    AsignacionEstudioDTO CreateStudyAssignment(String token, AsignacionEstudioDTO dto);
    /**
     * Reagenda una cita existente cancelando la anterior y creando una nueva.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la cita original y los nuevos datos de reagendación
     * @return CitaDTO con la información del nuevo control de estudio
     */
    CitaDTO UpdateStudyControl(String token, ReagendaCitaDTO dto);
    /**
     * Cancela una cita marcando el ControlEstudio, la SolicitudDeEstudio y la AsignacionEstudio como cancelados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos del control de estudio a cancelar
     */
    void CancelStudyControl (String token, CancelaCitaDTO dto);
    /**
     * Cancela en el RIS las citas que fueron canceladas desde el consultorio del médico.
     * @param token JSON del subject JWT con datos de la sesión activa
     */
    void Consultorio(String token);
    /**
     * Retorna las solicitudes de estudio pendientes de programación aplicando los filtros indicados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Filtros de búsqueda (nombre y/o apellido del paciente)
     * @return Lista de SolicitudDeEstudioDTO con las solicitudes en estado "SOLICITADO"
     */
    List<SolicitudDeEstudioDTO> getStudyOrders (String token, FiltroDTO dto);
}
