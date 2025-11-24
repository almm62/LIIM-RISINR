package com.UAM.RISINR.service.citas.implementations;

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
import com.UAM.RISINR.model.MedicoPK;
import com.UAM.RISINR.model.Paciente;
import com.UAM.RISINR.model.SolicitudDeEstudio;
import com.UAM.RISINR.model.SolicitudDeEstudioPK;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;
import com.UAM.RISINR.repository.AsignacionEstudioRepository;
import com.UAM.RISINR.repository.ControlEstudiosRepository;
import com.UAM.RISINR.repository.EquipoImagenologiaRepository;
import com.UAM.RISINR.repository.EquipoRepository;
import com.UAM.RISINR.repository.EstudioRepository;
import com.UAM.RISINR.repository.PacienteRepository;
import com.UAM.RISINR.repository.SolicitudDeEstudioRepository;
import com.UAM.RISINR.repository.UsuarioRepository;
import com.UAM.RISINR.service.citas.CitasService;
import com.UAM.RISINR.service.model.JwtSessionInfo;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.fasterxml.jackson.databind.ObjectMapper;

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
    private final ObjectMapper objectMapper;

    public CitasServiceImpl(RegistroEventoService registroEvento, UsuarioRepository usuarioRepo, EquipoImagenologiaRepository eqpImagRepo,
                            EstudioRepository estudioRepo, SolicitudDeEstudioRepository seRepo,
                            EquipoRepository equipoRepo, AsignacionEstudioRepository aeRepo, ControlEstudiosRepository controlEstudiosRepo, 
                            PacienteRepository paRepo, ObjectMapper objectMapper){
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
    }
    

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
        List<SalaDTO> salas = equipos.stream()
                                     .map(e ->{
                                        String sala = e.getUbicacion();
                                        String ubicacion = "Sala " + e.getUbicacion();
                                        return new SalaDTO(ubicacion,sala);
                                     })
                                     .collect(Collectors.toList());
        return salas;
    }

    @Override
    public List<CitaDTO> getAll(String token) {
        
        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        /* -- Principales Filtros */
        AreaDeServicio area = us.getAreaidArea();
        List<Estudio> es = estudioRepo.findByAreaDeServicioidArea(area);
        List<String> estados = List.of("Programado", "Reprogramado");

        /* Entidad Principal */
        List<ControlEstudios> ce = controlEstudiosRepo.findByEstudioInAndEstadoInAndCerradoIsFalse(es, estados);
        
        List<CitaDTO> citadto = ce.stream()
                                    .map(_ce -> {
                                        CitaDTO dto = citaToDto(_ce);
                                        return dto;
                                    })
                                    .collect(Collectors.toList());

        return citadto;
    }
    
    @Override
    @Transactional
    public CitaDTO CreateStudyControl (String token, AgendaCitaDTO dto){
        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        AreaDeServicio area = us.getAreaidArea();
        var es = estudioRepo.findById(dto.getIdestudio());
        
        if(es.isEmpty()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Estudio no existe");
        }
        if(!es.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        var pa = paRepo.findById(dto.getIdpaciente());
        if(pa.isEmpty()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Paciente no se encontró");
        }

        ControlEstudiosPK cePk = new ControlEstudiosPK(us.getUsuarioPK().getNumEmpleado(), 
                                                       us.getUsuarioPK().getCurp(), 
                                                       dto.getIdpaciente(),
                                                       dto.getIdestudio(), 
                                                       dto.getFechacontrolpk(),
                                                       dto.getEqNoSerie(),
                                                       dto.getMedNumEmpleado(),
                                                       dto.getMedCurp());

        ControlEstudios ce = new ControlEstudios(cePk, dto.getFechacontrol(), dto.getEstado(),
                                                 dto.getCerrado(), dto.getObservaciones());
        ce.setEstudio(es.get());
        ce.setPaciente(pa.get());
        ce.setUsuario(us);
        controlEstudiosRepo.save(ce);

        CitaDTO ceDto = citaToDto(ce);
        return ceDto;
    }

    
    
    @Override
    @Transactional
    public AsignacionEstudioDTO CreateStudyAssignment (String token, AsignacionEstudioDTO dto){

        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
        }catch (Exception e){
            
        }
        AreaDeServicio area = us.getAreaidArea();
        /* ----------- Validaciones ------------*/ 

        // Estudio existe
        var es = estudioRepo.findById(dto.getIdestudio());
        if(es.isEmpty()){
            System.out.println("1");
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Estudio no existe");
        }
        
        // Estudio no pertenece al area del usuario
        if(!es.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            System.out.println("2");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // AsignacionEstudio no existente
        AsignacionEstudioPK aePK = new AsignacionEstudioPK(dto.getEqNoSerie(), dto.getIdestudio(), dto.getFechacontrolpk());
        var ae  = aeRepo.findById(aePK);
        if(ae.isPresent()){
            System.out.println("3");
            throw new ResponseStatusException(HttpStatus.CONFLICT, "AsignacionEstudio existente");
        }

        // EquipoImagenologia existe
        var eqImag = eqpImagRepo.findById(dto.getEqNoSerie());
        if(eqImag.isEmpty()){
            System.out.println("4");
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "EquipoImagenología no existe");
        }

        // EquipoImagenologia está disponible
        if(!eqImag.get().getEstado().equals("Disponible")){
            System.out.println("5");
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible");
        }
        // EquipoImagenologia pertenece al area del usuario
        if(!eqImag.get().getAreaDeServicioidArea().getIdArea().equals(area.getIdArea())){
            System.out.println("6");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Area no compatible");
        }

        // Disponibilidad del EquipoImagenologia en la fecha y hora solicitada
        if(!aeRepo.findByEquipoImagenologiaAndAsignacionEstudioPK_FechaPkAndEstado(eqImag.get(), dto.getFechacontrolpk(), "Activo").isEmpty()){
            System.out.println("7");
            throw new ResponseStatusException(HttpStatus.CONFLICT, "EquipoImagenología no disponible en la fecha y hora solicitada");
        }

        // SolicitudDeEstudio existe
        SolicitudDeEstudioPK sePk = new SolicitudDeEstudioPK(dto.getIdPaciente(), dto.getMedNumEmpleado(), dto.getMedCurp(), dto.getFechacontrolpk());
        var se = seRepo.findById(sePk);
        if(se.isEmpty()){
            System.out.println("8");
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "SolicitudDeEstudio no existe");
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

        return dto;
    }


    
    
    @Override
    public CitaDTO UpdateStudyControl (String token, ReagendaCitaDTO dto){
        Usuario us= null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            us = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
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
                                                    dto.getMedCurp());

        CancelStudyControl(cancela);
        
        AsignacionEstudioPK aePk = new AsignacionEstudioPK(dto.getNoSerie(), dto.getIdestudio(), dto.getFechacontrolpk_ant());
        AsignacionEstudio ae = aeRepo.findById(aePk).get();


        AsignacionEstudioDTO asignacion = new AsignacionEstudioDTO(ae.getEquipoImagenologia().getnSerie(), 
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
                                                                                  
        SolicitudDeEstudio se = seRepo.findBySolicitudDeEstudioPK_fechaSolicitudPkAndPaciente(dto.getFechacontrolpk_ant(), 
                                                                                              paRepo.findById(dto.getIdpaciente()).get())
                                                                                              .get(0);
        createStudyRequest(se, dto.getFechacontrolpk_nueva());
        CreateStudyAssignment(token, asignacion);

        CitaDTO ceDto = CreateStudyControl(token, agenda);
        return ceDto;
    }

    
    @Override
    public void CancelStudyControl (CancelaCitaDTO dto){

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
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "ControlEstudio no existe");
        }
        ControlEstudios ce = _ce.get();
        
        //Cerrar Control de Estudio actual
        ce.setCerrado(true);
        ce.setEstado("Cerrado");
        controlEstudiosRepo.save(ce);

        //Cancelar la Solicitud de estudio
        SolicitudDeEstudioPK sePk = new SolicitudDeEstudioPK(dto.getIdpaciente(), 
                                            dto.getMedNumEmpleado(), 
                                            dto.getMedCurp(),
                                            dto.getFechacontrolpk());
    }


    private CitaDTO citaToDto(ControlEstudios ce){
        CitaDTO dto = new CitaDTO();
        
        
        Usuario ce_usr = ce.getUsuario();
        Paciente paciente = ce.getPaciente();
        List<AsignacionEstudio> ae = aeRepo.findByEstudioAndAsignacionEstudioPK_FechaPk(ce.getEstudio(), ce.getControlEstudiosPK().getFechaControlPk());

        List<SolicitudDeEstudio> se = seRepo.findBySolicitudDeEstudioPK_fechaSolicitudPkAndPaciente(ce.getControlEstudiosPK().getFechaControlPk(), ce.getPaciente());
        Usuario med = usuarioRepo.findById(new UsuarioPK(se.get(0).getMedico().getMedicoPK().getNumEmpleado(),se.get(0).getMedico().getMedicoPK().getCurp())).get();
                
        Equipo eq = equipoRepo.findById(ae.get(0).getEquipoImagenologia().getnSerie()).get();
        

        dto.setCe_Estado(ce.getEstado());
        dto.setCe_usr_curp(ce_usr.getUsuarioPK().getCurp());
        dto.setFechaAsignPk(ce.getControlEstudiosPK().getFechaControlPk());
        dto.setEq_NoSerie(eq.getNSerie());
        dto.setEq_Ubicacion(eq.getUbicacion());
        dto.setFechaProxima(se.get(0).getFechaProximaCita().toString());
        dto.setMedico(ce_usr.getApellidoPaterno()+" "+ce_usr.getApellidoMaterno()+" "+ce_usr.getNombre());
        dto.setPaciente(paciente.getApellidoMaterno()+" "+ paciente.getApellidoMaterno()+" "+ paciente.getNombre());
        dto.setIdPaciente(paciente.getIdPaciente());
        dto.setNoEmpleado(med.getUsuarioPK().getNumEmpleado());
        dto.setSe_Curp(med.getUsuarioPK().getCurp());
        dto.setNombreArea(ce_usr.getAreaidArea().getNombre());
        dto.setIdArea(ce_usr.getAreaidArea().getIdArea());
        dto.setFechaSolicitud(se.get(0).getFechaSolicitud().toString());
        dto.setAreaProcedencia(se.get(0).getAreaProcedencia());
        dto.setDiagnostico(se.get(0).getDiagnostico());
        dto.setObservaciones(se.get(0).getObservaciones());
        dto.setIdEstudio(ae.get(0).getEstudio().getIdEstudio());
        
        Domicilio domicilio = paciente.getDomicilio();
        dto.setDomicilio(domicilio.getCalle()+", "+
                         domicilio.getNumero()+", "+
                         domicilio.getColonia()+", "+
                         domicilio.getCp()+", "+
                         domicilio.getAlcaldiaMunicipio()+", "+
                         domicilio.getEstado());
        dto.setFechaCita(ce.getFechaControl().toString().split(" ")[0]);
        dto.setHoraCita(ce.getFechaControl().toString().split(" ")[1]);
        dto.setNoEmpleadoUsuario(ce_usr.getUsuarioPK().getNumEmpleado());
        dto.setEstudio(ce.getEstudio().getIdEstudio());


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
}