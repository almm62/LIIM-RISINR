package com.UAM.RISINR.service.citas.implementations;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.AsignacionEstudio;
import com.UAM.RISINR.model.AsignacionEstudioPK;
import com.UAM.RISINR.model.ControlEstudios;
import com.UAM.RISINR.model.ControlEstudiosPK;
import com.UAM.RISINR.model.Domicilio;
import com.UAM.RISINR.model.Equipo;
import com.UAM.RISINR.model.Estudio;
import com.UAM.RISINR.model.Medico;
import com.UAM.RISINR.model.MedicoPK;
import com.UAM.RISINR.model.Paciente;
import com.UAM.RISINR.model.SesionPK;
import com.UAM.RISINR.model.SolicitudDeEstudio;
import com.UAM.RISINR.model.SolicitudDeEstudioPK;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.FiltroDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;
import com.UAM.RISINR.model.dto.citas.SolicitudDeEstudioDTO;
import com.UAM.RISINR.repository.AsignacionEstudioRepository;
import com.UAM.RISINR.repository.ControlEstudiosRepository;
import com.UAM.RISINR.repository.EquipoImagenologiaRepository;
import com.UAM.RISINR.repository.EquipoRepository;
import com.UAM.RISINR.repository.EstudioRepository;
import com.UAM.RISINR.repository.MedicoRepository;
import com.UAM.RISINR.repository.PacienteRepository;
import com.UAM.RISINR.repository.SolicitudDeEstudioRepository;
import com.UAM.RISINR.repository.UsuarioRepository;
import com.UAM.RISINR.service.citas.CitasService;
import com.UAM.RISINR.service.model.JwtSessionInfo;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Implementación del servicio de gestión de citas. Contiene la lógica de negocio
 * para agendar, reagendar y cancelar controles de estudio, así como para crear
 * asignaciones de equipos de imagenología. Valida disponibilidad de recursos,
 * pertenencia al área del usuario y sincronización con solicitudes del consultorio.
 * Registra en bitácora cada operación exitosa o fallida.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Service
public class CitasServiceImpl implements CitasService{
    private final RegistroEventoService registroEvento;
    private final UsuarioRepository usuarioRepo;
    private final EquipoImagenologiaRepository eqpImagRepo;
    private final EstudioRepository estudioRepo;
    private final EquipoRepository equipoRepo;
    private final ControlEstudiosRepository controlEstudiosRepo;
    private final AsignacionEstudioRepository aeRepo;
    private final SolicitudDeEstudioRepository seRepo;
    private final PacienteRepository paRepo;
    private final MedicoRepository medicoRepo;
    private final ObjectMapper objectMapper;

    // APLICACIONES
    private static final int APLICACION_CONSULTA=7;
    private static final int APLICACION_AGENDA=8;
    private static final int APLICACION_REAGENDA=9;
    private static final int APLICACION_CANCELA=10;


    // EVENTOS Exitosos
    private static final int CONSULTA_CORRECTA=12;
    private static final int ASIGNACION_CORRECTA=13;
    private static final int AGENDA_CORRECTA=14;
    private static final int REAGENDA_CORRECTA=15;
    private static final int CANCELA_CORRECTA=16;
    // EVENTOS No Exitosos
    private static final int AGENDA_INCORRECTA=1014;
    private static final int ASIGNACION_INCORRECTA=1015;
    private static final int REAGENDA_INCORRECTA=1016;
    private static final int CANCELA_INCORRECTA=1017;
    
    
    /**
     * Constructor con inyección de todos los repositorios y servicios necesarios para la gestión de citas.
     * @param registroEvento Servicio de bitácora de eventos
     * @param usuarioRepo Repositorio de usuarios
     * @param eqpImagRepo Repositorio de equipos de imagenología
     * @param estudioRepo Repositorio de estudios
     * @param seRepo Repositorio de solicitudes de estudio
     * @param equipoRepo Repositorio de equipos
     * @param aeRepo Repositorio de asignaciones de estudio
     * @param controlEstudiosRepo Repositorio de controles de estudio
     * @param paRepo Repositorio de pacientes
     * @param medicoRepo Repositorio de médicos
     * @param objectMapper Mapper para serialización JSON
     */
    public CitasServiceImpl(RegistroEventoService registroEvento, UsuarioRepository usuarioRepo, EquipoImagenologiaRepository eqpImagRepo,
                            EstudioRepository estudioRepo, SolicitudDeEstudioRepository seRepo,
                            EquipoRepository equipoRepo, AsignacionEstudioRepository aeRepo, ControlEstudiosRepository controlEstudiosRepo,
                            PacienteRepository paRepo, MedicoRepository medicoRepo, ObjectMapper objectMapper){
        this.registroEvento=registroEvento;
        this.usuarioRepo=usuarioRepo;
        this.eqpImagRepo=eqpImagRepo;
        this.estudioRepo = estudioRepo;
        this.seRepo = seRepo;
        this.equipoRepo = equipoRepo;
        this.aeRepo = aeRepo;
        this.controlEstudiosRepo=controlEstudiosRepo;
        this.paRepo = paRepo;
        this.objectMapper = objectMapper;
        this.medicoRepo = medicoRepo;
    }
    

    /**
     * Retorna la lista de estudios disponibles en el área del usuario autenticado.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return Lista de EstudioDTO con los estudios del área
     */
    @Override
    @Transactional
    public List<EstudioDTO> getStudies(String token) {
        Usuario sesionUsr= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            sesionUsr = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        
        List<Estudio> estudios = estudioRepo.findByAreaDeServicioidArea(sesionUsr.getAreaidArea());
        // Mapeamos a DTO
        List<EstudioDTO> estudiosDto = estudios.stream()
                                    .map(e -> {
                                        Integer id = e.getIdEstudio();
                                        String nombre = e.getNombre() + " / " + e.getDescripcion();
                                        return new EstudioDTO(id,nombre);
                                    })
                                    .collect(Collectors.toList());
        return estudiosDto;
    }

    /**
     * Retorna la lista de salas disponibles en el área del usuario autenticado.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return Lista de SalaDTO con las ubicaciones de equipos del área
     */
    @Override
    public List<SalaDTO> getSalas(String token) {
        Usuario sesionUsr= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            sesionUsr = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        
        List<Equipo> equipos = equipoRepo.findByAreaDeServicioidArea(sesionUsr.getAreaidArea());
        List<String> _ubicaciones = equipos.stream()
                                        .map(e -> e.getUbicacion())
                                        .distinct()
                                        .collect(Collectors.toList());

        List<SalaDTO> salasDto = _ubicaciones.stream()
                                    .map(u -> {
                                        return new SalaDTO(u);
                                    })
                                    .collect(Collectors.toList());
        return salasDto;
    }

    /**
     * Retorna todas las citas activas del área aplicando los filtros indicados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param filtro Filtros de búsqueda (nombre y/o apellido del paciente)
     * @return Lista de CitaDTO con los controles de estudio que coinciden con los filtros
     */
    @Override
    public List<CitaDTO> getAll(String token, FiltroDTO filtro) {
        long hora= System.currentTimeMillis();
        String datos=" ";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(SesionPK SesionActiva) {}
        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
            var datosObj =new EventoDatos(new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj); 
        }catch (Exception e){
            
        }
        /* -- Principales Filtros */
        AreaDeServicio area = us.getAreaidArea();
        List<Estudio> es = estudioRepo.findByAreaDeServicioidArea(area);
        List<String> estados = List.of("Programado", "Reprogramado");

        /* Entidad Principal */
        List<ControlEstudios> ce;
        if(filtro.getNombre()==null && filtro.getApellido()==null){
            ce = controlEstudiosRepo.findByEstudioInAndEstadoInAndCerradoIsFalse(es, estados);
        } else{
            List<Paciente> pacientes = new ArrayList<>();
            if(filtro.getApellido()==null){
                pacientes = paRepo.findByNombreContaining(filtro.getNombre());
            } else if(filtro.getNombre()==null){
                pacientes = paRepo.findByApellidoPaternoContaining(filtro.getApellido());
            } else {
                pacientes = paRepo.findByNombreContainingAndApellidoPaternoContaining(filtro.getNombre(),filtro.getApellido());
            }
            ce = controlEstudiosRepo.findByEstudioInAndEstadoInAndPacienteInAndCerradoIsFalse(es, estados, pacientes);
        }
        
        List<CitaDTO> citadto = ce.stream()
                                    .map(_ce -> {
                                        CitaDTO dto = citaToDto(_ce);
                                        return dto;
                                    })
                                    .collect(Collectors.toList());
        registroEvento.log(CONSULTA_CORRECTA, APLICACION_CONSULTA, hora, datos);
        return citadto;
    }
    
    /**
     * Agenda una nueva cita creando un registro de ControlEstudio.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la cita a agendar
     * @return CitaDTO con la información del control de estudio creado
     */
    @Override
    @Transactional
    public CitaDTO CreateStudyControl (String token, AgendaCitaDTO dto){
        long hora= System.currentTimeMillis();
        String datos="";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(AgendaCitaDTO dto, SesionPK SesionActiva) {}

        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
            var datosObj =new EventoDatos(dto, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj); 
        }catch (Exception e){
            
        }
        AreaDeServicio area = us.getAreaidArea();
        
        /* ----------- Validaciones ------------*/ 
        // Estudio existe
        var es = estudioRepo.findById(dto.getIdestudio());
        if(es.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Estudio no existe");
        }
        
        // Estudio no pertenece al area del usuario
        if(!es.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // AsignacionEstudio existente
        AsignacionEstudioPK aePK = new AsignacionEstudioPK(dto.getEqNoSerie(), dto.getIdestudio(), dto.getFechacontrolpk());
        var ae  = aeRepo.findById(aePK);
        if(ae.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "AsignacionEstudio no existente");
        }
        // EquipoImagenologia existe
        var eqImag = eqpImagRepo.findById(dto.getEqNoSerie());
        if(eqImag.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "EquipoImagenología no existe");
        }

        // EquipoImagenologia está disponible
        if(!eqImag.get().getEstado().equals("Disponible")){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible");
        }

        if(!ae.get().getEstado().equals("Activo")){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "AsignacionEstudio no activa");
        }

        // EquipoImagenologia pertenece al area del usuario
        if(!eqImag.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // Disponibilidad del EquipoImagenologia en la fecha y hora solicitada
        if(!ae.get().getEstado().equals("Activo")){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible en la fecha y hora solicitada");
        }

        // SolicitudDeEstudio existe
        SolicitudDeEstudioPK sePk = new SolicitudDeEstudioPK(dto.getIdpaciente(), dto.getMedNumEmpleado(), dto.getMedCurp(), dto.getFechacontrolpk());
        var se = seRepo.findById(sePk);
        if(se.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "SolicitudDeEstudio no existe");
        }

        // Paciente existe
        var pa = paRepo.findById(dto.getIdpaciente());
        if(pa.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Paciente no se encontró");
        }
        //Medico existe
        MedicoPK medPk = new MedicoPK(dto.getMedNumEmpleado(), dto.getMedCurp());
        var med = medicoRepo.findById(medPk);
        if(med.isEmpty()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Médico no se encontró");
        }

        // Control de Estudio no existente
        ControlEstudiosPK cePk = new ControlEstudiosPK(us.getUsuarioPK().getNumEmpleado(), 
                                                       us.getUsuarioPK().getCurp(), 
                                                       dto.getIdpaciente(),
                                                       dto.getIdestudio(), 
                                                       dto.getFechacontrolpk(),
                                                       dto.getEqNoSerie(),
                                                       dto.getMedNumEmpleado(),
                                                       dto.getMedCurp());
        var _ce = controlEstudiosRepo.findById(cePk);
        if(_ce.isPresent()){
            registroEvento.log(AGENDA_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "ControlEstudio existente");
        }
        
        ControlEstudios ce = new ControlEstudios(cePk, dto.getFechacontrol(), dto.getEstado(),
                                                 dto.getCerrado(), dto.getObservaciones());
                                                
        ce.setMedico(med.get());
        ce.setEstudio(es.get());
        ce.setPaciente(pa.get());
        ce.setUsuario(us);
        controlEstudiosRepo.save(ce);

        SolicitudDeEstudio solicitudDeEstudio = se.get();
        solicitudDeEstudio.setEstado("Programado");
        CitaDTO ceDto = citaToDto(ce);
        registroEvento.log(AGENDA_CORRECTA, APLICACION_AGENDA, hora, datos);
        return ceDto;
    }    
    
    /**
     * Crea una asignación de estudio vinculando un equipo de imagenología a un estudio y fecha.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la asignación a crear
     * @return AsignacionEstudioDTO con los datos de la asignación registrada
     */
    @Override
    @Transactional
    public AsignacionEstudioDTO CreateStudyAssignment (String token, AsignacionEstudioDTO dto){
        long hora= System.currentTimeMillis();
        String datos="";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(AsignacionEstudioDTO dto, SesionPK SesionActiva) {}

        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
            var datosObj =new EventoDatos(dto, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj);
        }catch (Exception e){
            
        }
        AreaDeServicio area = us.getAreaidArea();
        /* ----------- Validaciones ------------*/ 

        // Estudio existe
        var es = estudioRepo.findById(dto.getIdestudio());
        if(es.isEmpty()){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Estudio no existe");
        }
        
        // Estudio no pertenece al area del usuario
        if(!es.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // AsignacionEstudio no existente
        AsignacionEstudioPK aePK = new AsignacionEstudioPK(dto.getEqNoSerie(), dto.getIdestudio(), dto.getFechacontrolpk());
        var ae  = aeRepo.findById(aePK);
        if(ae.isPresent()){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "AsignacionEstudio existente");
        }

        // EquipoImagenologia existe
        var eqImag = eqpImagRepo.findById(dto.getEqNoSerie());
        if(eqImag.isEmpty()){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "EquipoImagenología no existe");
        }

        // EquipoImagenologia está disponible
        if(!eqImag.get().getEstado().equals("Disponible")){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible");
        }
        // EquipoImagenologia pertenece al area del usuario
        if(!eqImag.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // Disponibilidad del EquipoImagenologia en la fecha y hora solicitada
        if(!aeRepo.findByEquipoImagenologiaAndAsignacionEstudioPK_FechaPkAndEstado(eqImag.get(), dto.getFechacontrolpk(), "Activo").isEmpty()){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible en la fecha y hora solicitada");
        }

        // SolicitudDeEstudio existe
        SolicitudDeEstudioPK sePk = new SolicitudDeEstudioPK(dto.getIdPaciente(), dto.getMedNumEmpleado(), dto.getMedCurp(), dto.getFechacontrolpk());
        var se = seRepo.findById(sePk);
        if(se.isEmpty()){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "SolicitudDeEstudio no existe");
        }

        //Validar que SolicitudDeEstudio == SOLICITADO
        if(!se.get().getEstado().equals("SOLICITADO")){
            registroEvento.log(ASIGNACION_INCORRECTA, APLICACION_AGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "SolicitudDeEstudio ya ha sido programado, reprogramado o cancelado 'Solicitado'");
        }

        /* ---------------Crear AsignacionEstudio--------------- */
        AsignacionEstudio asignacionEstudio = new AsignacionEstudio(aePK, dto.getFechacontrol(), "Activo");
        asignacionEstudio.setEquipoImagenologia(eqImag.get());
        asignacionEstudio.setEstudio(es.get());
        aeRepo.save(asignacionEstudio);

        /* -------------- Actualizar estado de SolicitudDeEstudio --------------*/
        SolicitudDeEstudio solicitudDeEstudio = se.get();
        solicitudDeEstudio.setEstado("Equipo Asignado");
        seRepo.save(solicitudDeEstudio);

        registroEvento.log(ASIGNACION_CORRECTA, APLICACION_AGENDA, hora, datos);

        return dto;
    }
    
    
    /**
     * Reagenda una cita existente cancelando la anterior y creando una nueva.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos de la cita original y los nuevos datos de reagendación
     * @return CitaDTO con la información del nuevo control de estudio
     */
    @Override
    public CitaDTO UpdateStudyControl (String token, ReagendaCitaDTO dto){
        long hora= System.currentTimeMillis();
        String datos="";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(ReagendaCitaDTO dto, SesionPK SesionActiva) {}
        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            var datosObj =new EventoDatos(dto, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj);
        }catch (Exception e){
            
        }
        
        CancelaCitaDTO cancela = new CancelaCitaDTO(dto.getUserNumEmpleado(), 
                                                    dto.getUserCurp(),
                                                    dto.getIdestudio(),
                                                    dto.getIdpaciente(),
                                                    dto.getFechacontrolpk_ant(),
                                                    dto.getMotivo(),
                                                    dto.getNoSerie(),
                                                    dto.getMedNumEmpleado(),
                                                    dto.getMedCurp(),
                                                    "Reprogramado");

        CancelStudyControl(token, cancela);


        AsignacionEstudioDTO asignacion = new AsignacionEstudioDTO(dto.getNoSerie(), 
                                                                   dto.getIdestudio(), 
                                                                   dto.getFechacontrolpk_nueva(),
                                                                   dto.getFechacontrol_nueva(),
                                                                   dto.getIdpaciente(),
                                                                   dto.getMedNumEmpleado(),
                                                                   dto.getMedCurp());
        
        AgendaCitaDTO agenda = new AgendaCitaDTO(dto.getIdpaciente(),
                                                 dto.getIdestudio(), 
                                                 dto.getFechacontrolpk_nueva(), 
                                                 dto.getFechacontrol_nueva(), 
                                                 dto.getEstado(), 
                                                 dto.getCerrado(), 
                                                 dto.getObservaciones(),
                                                 dto.getNoSerie(),
                                                 dto.getMedNumEmpleado(),
                                                 dto.getMedCurp());
                                                                                  
        var se = seRepo.findById(new SolicitudDeEstudioPK(dto.getIdpaciente(), 
                                                                      dto.getMedNumEmpleado(),
                                                                        dto.getMedCurp(),
                                                                        dto.getFechacontrolpk_nueva()));
        if(se.isEmpty()){
            registroEvento.log(REAGENDA_INCORRECTA, APLICACION_REAGENDA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "SolicitudDeEstudio no existe");
        }
        
        createStudyRequest(se.get(), dto.getFechacontrolpk_nueva());
        CreateStudyAssignment(token, asignacion);

        CitaDTO resp = CreateStudyControl(token, agenda);
        registroEvento.log(REAGENDA_CORRECTA, APLICACION_REAGENDA, hora, datos);
        return resp;
    }

    
    /**
     * Cancela una cita marcando el ControlEstudio, la SolicitudDeEstudio y la AsignacionEstudio como cancelados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param dto Datos del control de estudio a cancelar
     */
    @Override
    public void CancelStudyControl (String token, CancelaCitaDTO dto){
        long hora= System.currentTimeMillis();
        String datos="";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(CancelaCitaDTO dto, SesionPK SesionActiva) {}
        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            var datosObj =new EventoDatos(dto, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj);
        }catch (Exception e){
            
        }

        // Validar existencia de ControlEstudio
        ControlEstudiosPK cePk = new ControlEstudiosPK(dto.getNumEmpleado(), 
                                                       dto.getCurp(), 
                                                       dto.getIdpaciente(),
                                                       dto.getIdestudio(), 
                                                       dto.getFechacontrolpk(),
                                                       dto.getNoSerie(),
                                                       dto.getMedNumEmpleado(),
                                                       dto.getMedCurp());
        var _ce = controlEstudiosRepo.findById(cePk);
        if(_ce.isEmpty()){
            registroEvento.log(CANCELA_INCORRECTA, APLICACION_CANCELA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "ControlEstudio no existe");
        }

        ControlEstudios ce = _ce.get();
        
        //Cerrar Control de Estudio actual
        ce.setCerrado(true);
        ce.setEstado(dto.getEstado());
        controlEstudiosRepo.save(ce);

        /* Cancelar la Solicitud de estudio */
        SolicitudDeEstudioPK sePk = new SolicitudDeEstudioPK(dto.getIdpaciente(), 
                                            dto.getMedNumEmpleado(), 
                                            dto.getMedCurp(),
                                            dto.getFechacontrolpk());
        var _se = seRepo.findById(sePk);
        if(_se.isEmpty()){
            registroEvento.log(CANCELA_INCORRECTA, APLICACION_CANCELA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "SolicitudDeEstudio no existe");
        }
        SolicitudDeEstudio se = _se.get();
        se.setEstado("Cancelado");
        seRepo.save(se);

        /* Cancelar Asignacion de Estudio */
        AsignacionEstudioPK aePk = new AsignacionEstudioPK(dto.getNoSerie(), dto.getIdestudio(), dto.getFechacontrolpk());
        var _ae = aeRepo.findById(aePk);
        if(_ae.isEmpty()){
            registroEvento.log(CANCELA_INCORRECTA, APLICACION_CANCELA, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "AsignacionEstudio no existe");
        }
        AsignacionEstudio ae = _ae.get();
        ae.setEstado("Cancelado");
        aeRepo.save(ae);
        registroEvento.log(CANCELA_CORRECTA, APLICACION_CANCELA, hora, datos);
    }


    private CitaDTO citaToDto(ControlEstudios ce){
        CitaDTO dto = new CitaDTO();
        
        
        Usuario ce_usr = ce.getUsuario();
        Paciente paciente = ce.getPaciente();
        Medico medico = ce.getMedico();
        Estudio estudio = ce.getEstudio();
        Equipo eq = equipoRepo.findById(ce.getControlEstudiosPK().getEquipoImagenologiaNSerie()).get();

        AsignacionEstudio ae = aeRepo.findById(new AsignacionEstudioPK(eq.getNSerie(),
                                                                       estudio.getIdEstudio(),
                                                                       ce.getControlEstudiosPK().getFechaControlPk())).get();

        SolicitudDeEstudio se = seRepo.findById(new SolicitudDeEstudioPK(paciente.getIdPaciente(), 
                                                                         medico.getMedicoPK().getNumEmpleado(),
                                                                         medico.getMedicoPK().getCurp(),
                                                                         ce.getControlEstudiosPK().getFechaControlPk())).get();

        dto.setCe_Estado(ce.getEstado());
        dto.setCe_usr_curp(ce_usr.getUsuarioPK().getCurp());
        dto.setFechaAsignPk(ce.getControlEstudiosPK().getFechaControlPk());
        dto.setEq_NoSerie(eq.getNSerie());
        dto.setEq_Ubicacion(eq.getUbicacion());
        dto.setFechaProxima(se.getFechaProximaCita().toString());
        dto.setMedico(ce_usr.getApellidoPaterno()+" "+ce_usr.getApellidoMaterno()+" "+ce_usr.getNombre());
        dto.setPaciente(paciente.getApellidoPaterno()+" "+ paciente.getApellidoMaterno()+" "+ paciente.getNombre());
        dto.setIdPaciente(paciente.getIdPaciente());
        dto.setNoEmpleado(medico.getMedicoPK().getNumEmpleado());
        dto.setSe_Curp(medico.getMedicoPK().getCurp());
        dto.setNombreArea(ce_usr.getAreaidArea().getNombre());
        dto.setIdArea(ce_usr.getAreaidArea().getIdArea());
        dto.setFechaSolicitud(se.getFechaSolicitud().toString());
        dto.setAreaProcedencia(se.getAreaProcedencia());
        dto.setDiagnostico(se.getDiagnostico());
        dto.setObservaciones(se.getObservaciones());
        dto.setIdEstudio(ae.getEstudio().getIdEstudio());
        
        Domicilio domicilio = paciente.getDomicilio();
        dto.setDomicilio(domicilio.getCalle()+", "+
                         domicilio.getNumero()+", "+
                         domicilio.getColonia()+", "+
                         domicilio.getCp()+", "+
                         domicilio.getAlcaldiaMunicipio()+", "+
                         domicilio.getEstado());
        dto.setNoEmpleadoUsuario(ce_usr.getUsuarioPK().getNumEmpleado());
        dto.setEstudio(ce.getEstudio().getNombre()+" / "+ce.getEstudio().getDescripcion());


        return dto;
    }

    @Transactional
    private void createStudyRequest(SolicitudDeEstudio solEs, Long fechaPK){
        SolicitudDeEstudioPK sePK_ = solEs.getSolicitudDeEstudioPK();
        SolicitudDeEstudioPK sePK  = new SolicitudDeEstudioPK(sePK_.getPacienteidPaciente(),
                                                                sePK_.getMedicoNumEmpleado(), 
                                                                sePK_.getMedicoCURP(), 
                                                                fechaPK);

        SolicitudDeEstudio se = new SolicitudDeEstudio(sePK,
                                                       solEs.getFechaSolicitud(), 
                                                       solEs.getFechaProximaCita(), 
                                                       solEs.getDiagnostico(), 
                                                       solEs.getObservaciones(), 
                                                       solEs.getEstado());

        se.setAreaProcedencia(solEs.getAreaProcedencia());
        se.setMedico(solEs.getMedico());
        se.setPaciente(solEs.getPaciente());
         
        seRepo.save(se);
    }

    /**
     * Cancela en el RIS las citas que fueron canceladas desde el consultorio del médico.
     * @param token JSON del subject JWT con datos de la sesión activa
     */
    @Transactional
    public void Consultorio(String token){
        long hora= System.currentTimeMillis();
        String datos="";
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(List<ControlEstudiosPK> citas,SesionPK SesionActiva) {}
        //inicializamos lista de citas canceladas
        List<ControlEstudiosPK> citasCanceladas = new ArrayList<>();

        /* Encontramos estudios cancelados en SolicitudEstudio filtrando por Estudio y Estado */
        List<SolicitudDeEstudio> se = seRepo.findByEstado("Cancelado consultorio");
        if(se.size()==0){
            return;
        }
        for(SolicitudDeEstudio solicitud : se){
            SolicitudDeEstudioPK sePk = solicitud.getSolicitudDeEstudioPK();
            /* Cancelamos los controles de estudio asociados a la solicitud de estudio */
            List<ControlEstudios> controles = controlEstudiosRepo.findByControlEstudiosPK_FechaControlPkAndMedicoAndPacienteAndEstadoNot(
                                                                    sePk.getFechaSolicitudPk(), 
                                                                    solicitud.getMedico(),
                                                                    solicitud.getPaciente(),
                                                                    "Cancelado");
            if(controles.size()==0){
                continue;
            }
            for(ControlEstudios ce : controles){
                ControlEstudiosPK cePk = ce.getControlEstudiosPK();
                
                CancelaCitaDTO cancela = new CancelaCitaDTO(cePk.getUsuarioNumEmpleado(),
                                                    cePk.getUsuarioCURP(),
                                                    cePk.getEstudioidEstudio(),
                                                    cePk.getPacienteIDPaciente(),
                                                    cePk.getFechaControlPk(),
                                                    "Cancelado por consultorio",
                                                    cePk.getEquipoImagenologiaNSerie(),
                                                    cePk.getMedicoNumEmpleado(),
                                                    cePk.getMedicoCURP(),
                                                    "Cancelado");
                CancelStudyControl(token, cancela);
                //Agregamos a la lista de citas canceladas
                citasCanceladas.add(cePk);
            }
        }
        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            var datosObj =new EventoDatos(citasCanceladas, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj);
        }catch (Exception e){
        }
        registroEvento.log(CANCELA_CORRECTA, APLICACION_CANCELA, hora, datos);
    }

    /**
     * Retorna las solicitudes de estudio pendientes de programación aplicando los filtros indicados.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @param filtro Filtros de búsqueda (nombre y/o apellido del paciente)
     * @return Lista de SolicitudDeEstudioDTO con las solicitudes en estado "SOLICITADO"
     */
    @Transactional
    public List<SolicitudDeEstudioDTO> getStudyOrders (String token, FiltroDTO filtro){
        Usuario sesionUsr= null;
        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            sesionUsr = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        List<SolicitudDeEstudio> solicitudes;
        solicitudes = seRepo.findByEstado("SOLICITADO");

        // Mapeamos a DTO
        List<SolicitudDeEstudioDTO> solicitudesDto = solicitudes.stream()
                                    .map(se -> {
                                        Usuario medicoUsr = usuarioRepo.findById(new UsuarioPK(se.getMedico().getMedicoPK().getNumEmpleado(),
                                                                                             se.getMedico().getMedicoPK().getCurp())).get();
                                        SolicitudDeEstudioDTO dto = new SolicitudDeEstudioDTO();
                                        dto.setIdPaciente(se.getPaciente().getIdPaciente());
                                        dto.setNoEmpleado(se.getMedico().getMedicoPK().getNumEmpleado());
                                        dto.setCurp(se.getMedico().getMedicoPK().getCurp());
                                        dto.setFechaSolicitud(se.getFechaSolicitud().toString());
                                        dto.setDiagnostico(se.getDiagnostico());
                                        dto.setObservaciones(se.getObservaciones());
                                        dto.setFechaProxima(se.getFechaProximaCita().toString());
                                        dto.setPaciente(se.getPaciente().getNombre()+ " " +
                                                        se.getPaciente().getApellidoPaterno()+ " " +
                                                        se.getPaciente().getApellidoMaterno());
                                        dto.setMedico(medicoUsr.getNombre()+ " " +
                                                      medicoUsr.getApellidoPaterno()+ " " +
                                                      medicoUsr.getApellidoMaterno());
                                        dto.setAreaProcedencia(se.getAreaProcedencia());
                                        dto.setFechaSolicitudPK(se.getSolicitudDeEstudioPK().getFechaSolicitudPk());

                                        return dto;
                                    })
                                    .collect(Collectors.toList());
        return solicitudesDto;
    }
}