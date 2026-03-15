package com.UAM.RISINR.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.FiltroDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;
import com.UAM.RISINR.model.dto.citas.SolicitudDeEstudioDTO;
import com.UAM.RISINR.service.citas.CitasService;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Controlador REST para manejar las operaciones relacionadas con
 * Citas y Estudios médicos.
 * Proporciona endpoints para consultar, agendar, reagendar y cancelar citas,
 * así como para gestionar estudios y solicitudes de estudios.
 * Utiliza el servicio CitasService para la lógica de negocio.
 * 
 * Endpoints disponibles:
 * - /citas/getStudies : Obtiene la lista de estudios disponibles.
 * - /citas/getSala : Obtiene la lista de salas disponibles.
 * - /citas/getAll : Obtiene todas las citas según filtros especificados.
 * - /citas/CreateStudyControl : Agenda una nueva cita.
 * - /citas/CreateStudyAssignment : Asigna un estudio a un paciente.
 * - /citas/UpdateStudyControl : Reagenda una cita existente.
 * - /citas/cancel : Cancela una cita.
 * - /citas/consultorio : Cancelar citas que se cancelaron en consultorio.
 * - /citas/getStudyOrders : Obtiene las solicitudes de estudios según filtros.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
@RestController
@RequestMapping("/citas")
public class CitasController {
    
    /**
     * Interfaz que permite aislar la implementación de la lógica de negocio
     * permitiendo un mayor desacoplamiento.
     */
    private final CitasService citasService;

    
    /**
     * Constructor del controlador que inyecta el servicio de citas.
     * @param citasService instancia del CitasService
     */
    public CitasController(CitasService citasService) {
        this.citasService = citasService;
    }
    
    /**
     * Endpoint para obtener la lista de estudios disponibles pertenecientes al area de servicio.
     * Verifica la autenticación del usuario y consulta los estudios
     * 
     * @param httpReq solicitud HTTP
     * @return ResponseEntity con la lista de {@link EstudioDTO} y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @GetMapping("/getStudies")
    public ResponseEntity<List<EstudioDTO>> getStudies(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        List<EstudioDTO> resultados = citasService.getStudies(subjectJson);
        //Lista de Estudios
        return ResponseEntity.ok(resultados);
    }
    
    /**
     * Endpoint para obtener la lista de salas disponibles del area de servicio.
     * Verifica la autenticación del usuario y consulta las salas
     * según los permisos del usuario autenticado.
     * 
     * @param httpReq solicitud HTTP
     * @return ResponseEntity con la lista de {@link SalaDTO} y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */    
    @GetMapping("/getSala")
    public ResponseEntity<List<SalaDTO>> getSala(HttpServletRequest httpReq) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        List<SalaDTO> resultado = citasService.getSalas(subjectJson);

        return ResponseEntity.ok(resultado);
    }
    
    /**
     * Endpoint para obtener todas las citas según filtros especificados del area de servicio.
     * Recibe un JSON en el cuerpo de la petición con los filtros a aplicar,
     * que se mapea automáticamente a un objeto {@link FiltroDTO}.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los filtros para la consulta
     * @return ResponseEntity con la lista de {@link CitaDTO} y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/getAll")
    public ResponseEntity<List<CitaDTO>> getAll(HttpServletRequest httpReq,
                                                @RequestBody FiltroDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        List<CitaDTO> citas =citasService.getAll(subjectJson, dto);
        return ResponseEntity.ok(citas);
    }
    
    /**
     * Endpoint para agendar una nueva cita.
     * Recibe un JSON en el cuerpo de la petición con los datos de la cita,
     * que se mapea automáticamente a un objeto {@link AgendaCitaDTO}.
     * Envía la información al servicio y devuelve el DTO de la cita creada.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los datos de la cita a agendar
     * @return ResponseEntity con el {@link CitaDTO} de la cita creada y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/CreateStudyControl")
    public ResponseEntity<CitaDTO> CreateStudyControl(HttpServletRequest httpReq, 
                                          @RequestBody AgendaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        CitaDTO cita = citasService.CreateStudyControl(subjectJson,dto);     
        //Cita recien creada
        return ResponseEntity.ok(cita);
    }
    
    /**
     * Endpoint para asignar un estudio a un equipo de imagenología.
     * Recibe un JSON en el cuerpo de la petición con los datos de la asignación,
     * que se mapea automáticamente a un objeto {@link AsignacionEstudioDTO}.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los datos de la asignación del estudio
     * @return ResponseEntity con el {@link AsignacionEstudioDTO} del resultado y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/CreateStudyAssignment")
    public ResponseEntity<AsignacionEstudioDTO> CreateStudyAssignment(HttpServletRequest httpReq, 
                                          @RequestBody AsignacionEstudioDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        AsignacionEstudioDTO resultado= citasService.CreateStudyAssignment(subjectJson,dto);
        return ResponseEntity.ok(resultado);
    }
    
    /**
     * Endpoint para reagendar una cita existente.
     * Recibe un JSON en el cuerpo de la petición con los nuevos datos de la cita,
     * que se mapea automáticamente a un objeto {@link ReagendaCitaDTO}.
     * Envía la información al servicio y devuelve el DTO de la cita actualizada.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los datos para reagendar la cita
     * @return ResponseEntity con el {@link CitaDTO} de la cita reagendada y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/UpdateStudyControl")
    public ResponseEntity<CitaDTO> UpdateStudyControl(HttpServletRequest httpReq, 
                                          @RequestBody ReagendaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();
        
        CitaDTO cita = citasService.UpdateStudyControl(subjectJson, dto);

        return ResponseEntity.ok(cita);
    }

    /**
     * Endpoint para cancelar una cita.
     * Recibe un JSON en el cuerpo de la petición con los datos de cancelación,
     * que se mapea automáticamente a un objeto {@link CancelaCitaDTO}.
     * Envía la información al servicio para procesar la cancelación.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los datos de la cita a cancelar
     * @return ResponseEntity con código HTTP 200 si la cancelación fue exitosa,
     *         o código HTTP 401 si no está autenticado
     */    
    @PostMapping("/cancel")
    public ResponseEntity<CitaDTO> cancel(HttpServletRequest httpReq, 
                                          @RequestBody CancelaCitaDTO dto) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();

        citasService.CancelStudyControl(subjectJson,dto);
        return ResponseEntity.ok().build();
    }

    /**
     * Endpoint que cancela citas en el RIS, cuando estas fueron 
     * canceladas desde el consultorio del medico.
     * Se ejecuta automáticamente.
     * Verifica la autenticación del usuario y ejecuta operaciones
     * relacionadas con el consultorio.
     * 
     * @param httpReq solicitud HTTP
     * @return ResponseEntity con código HTTP 200 si la operación fue exitosa,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/consultorio")
    public ResponseEntity<Void> consultorio(HttpServletRequest httpReq) {     
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();   
        citasService.Consultorio(subjectJson);
        return ResponseEntity.ok().build();
    }

    /**
     * Endpoint para obtener las solicitudes de estudios según filtros especificados.
     * Recibe un JSON en el cuerpo de la petición con los filtros a aplicar,
     * que se mapea automáticamente a un objeto {@link FiltroDTO}.
     * 
     * @param httpReq solicitud HTTP
     * @param dto objeto con los filtros para la consulta
     * @return ResponseEntity con la lista de {@link SolicitudDeEstudioDTO} y código HTTP 200,
     *         o código HTTP 401 si no está autenticado
     */
    @PostMapping("/getStudyOrders")
    public ResponseEntity<List<SolicitudDeEstudioDTO>> getStudyOrders(HttpServletRequest httpReq,
                                                                        @RequestBody FiltroDTO dto) {     
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String subjectJson = (String) auth.getPrincipal();   
        List<SolicitudDeEstudioDTO> solicitudes = citasService.getStudyOrders(subjectJson, dto);
        return ResponseEntity.ok(solicitudes);
    }
}