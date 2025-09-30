package com.UAM.RISINR.service.user.implementations;

import com.UAM.RISINR.model.DatosAcceso;
import com.UAM.RISINR.model.DatosAccesoPK;
import com.UAM.RISINR.model.Perfil;
import com.UAM.RISINR.model.PerfilPK;
import com.UAM.RISINR.model.SesionPK;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.DatosAccesoRepository;
import com.UAM.RISINR.repository.PerfilRepository;
import com.UAM.RISINR.repository.RolRepository;
import com.UAM.RISINR.repository.SesionRepository;
import com.UAM.RISINR.repository.UsuarioRepository;
import com.UAM.RISINR.service.model.JwtSessionInfo;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.UAM.RISINR.service.user.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
public class UserServiceImpl implements UserService{
    private final RegistroEventoService registroEvento;
    private final UsuarioRepository usuarioRepo;
    private final DatosAccesoRepository datosAccesoRepo;
    private final AreaDeServicioRepository areaDeServicioRepo;
    private final PerfilRepository perfilRepo;
    private final RolRepository rolRepo;
    private final SesionRepository sesionRepo;
    private final ObjectMapper objectMapper;
    
    private static final int USER_CREATE_SUCCESS=6;
    private static final int USER_UPDATE_SUCCESS=7;
    private static final int USER_DEACTIVATE_SUCCESS=8;
    private static final int USER_UNLOCKED_SUCCESS=9;
    private static final int USER_LOCKED_SUCCESS= 10;
    private static final int DUPLICATE_USER_PK=1006;
    private static final int USER_ID_LINKED_TO_ANOTHER=1007;
    private static final int EMAIL_LINKED_TO_ANOTHER=1008;
    private static final int INVALID_ROLE=1009;
    private static final int INVALID_AREA=1010;
    private static final int USER_PK_NOT_FOUND=1011;
    // Aplicación que registra el evento
    private static final int APLICACION_ALTA_USUARIOS = 6; // Separar por aplicaciones:
    private static final int APLICACION_ACTUALIZACION_USUARIOS = 5; // Separar por aplicaciones:
    
    
public UserServiceImpl(RegistroEventoService registroEvento, UsuarioRepository usuarioRepo, DatosAccesoRepository datosAccesoRepo, 
                        AreaDeServicioRepository areaDeServicioRepo, PerfilRepository perfilRepo, RolRepository rolRepo, 
                        ObjectMapper objectMapper, SesionRepository sesionRepo){
    this.registroEvento=registroEvento;
    this.areaDeServicioRepo=areaDeServicioRepo;
    this.usuarioRepo=usuarioRepo;
    this.datosAccesoRepo=datosAccesoRepo;
    this.perfilRepo=perfilRepo;
    this.rolRepo= rolRepo;
    this.objectMapper=objectMapper;
    this.sesionRepo = sesionRepo;
    }

    @Override
    @Transactional
    public List<UsuarioResumenDTO> getAll(String token) {
        Usuario sesionUsr= null;
        String sesionRol = null;
        List<Usuario> usuarios = null;

        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            var sesPK = sesionRepo.findById(new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            sesionRol = sesPK.get().getRolNombre();
            sesionUsr = usuarioRepo.findById(new UsuarioPK(info.getNumEmpleado(), info.getCurp())).get();
            System.out.println("Hola");
        }catch (Exception e){
            
        }
        if ("JefedelServicio".equals(sesionRol)){
            usuarios = usuarioRepo.findByAreaidArea(sesionUsr.getAreaidArea());
        } else{
            usuarios = usuarioRepo.findAll();
        }
        return usuarios.stream()
            .map(this::convertToResumenDTO)
            .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public UsuarioResumenDTO create(CrearUsuarioDTO dto, String token) {
        long hora= System.currentTimeMillis();
        // Generamos clase para evento Alta de Usuario
        record EventoDatos(CrearUsuarioDTO Usuario, SesionPK SesionActiva){}
        String datos=null;
        try{
            //Extaemos datos del token
            JwtSessionInfo info= objectMapper.readValue(token, JwtSessionInfo.class);
            var datosObj= new EventoDatos(dto, new SesionPK(info.getHoraInicio(),
                                                                                                                                info.getNumEmpleado(),
                                                                                                                                info.getCurp(),
                                                                                                                                info.getAplicacionId())
                                                                            );
            datos=objectMapper.writeValueAsString(datosObj); //Json Listo para registrar cualquier evento
            System.out.println("Hola");
        }catch (Exception e){
            
        }
        
        //Verificar que no exista UsuarioPK en la BD
        var usrPK = new UsuarioPK(dto.getNumEmpleado(),
                                                                        dto.getCurp());
        var matchUsuarioPK=usuarioRepo.findById(usrPK);
        if (matchUsuarioPK.isPresent()){
            registroEvento.log(DUPLICATE_USER_PK, APLICACION_ALTA_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "UsuarioPK ya existente");
        }
        //Verificar que no exista Correo en la BD
        var matchCorreoElectronico=usuarioRepo.findByCorreoElectronico(dto.getCorreoElectronico());
        if (matchCorreoElectronico.isPresent()){
            registroEvento.log(EMAIL_LINKED_TO_ANOTHER, APLICACION_ALTA_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Correo vinculado a otro usuario");
        }
        //Verificar que no exista UsuarioID en la BD
        var matchID=datosAccesoRepo.findByIdUsuarioID(dto.getUsuarioID());
        if (matchID.isPresent()){
            registroEvento.log(USER_ID_LINKED_TO_ANOTHER, APLICACION_ALTA_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "UsuarioID ya existente");
        }
        var area=areaDeServicioRepo.findById(dto.getArea());
        if (area.isEmpty()){
            registroEvento.log(INVALID_AREA, APLICACION_ALTA_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Rol no existe");
        }
        
        Usuario usr = new Usuario();
        usr.setUsuarioPK(usrPK);
        usr.setNombre(dto.getNombre());
        usr.setApellidoPaterno(dto.getApellidoPaterno());
        usr.setApellidoMaterno(dto.getApellidoMaterno());
        usr.setAreaidArea(area.get());
        usr.setCorreoElectronico(dto.getCorreoElectronico());
        usuarioRepo.save(usr);
        
        var accesoPK = new DatosAccesoPK(dto.getUsuarioID(),
                                                                                dto.getNumEmpleado(),
                                                                                dto.getCurp());
        var contraseña=dto.getCurp(); //Contraseña = curp, Al rpimer Login se le obliga a cambiar
        
        var acceso = new DatosAcceso();
        acceso.setId(accesoPK);
        acceso.setEstado("Activo");
        acceso.setContrasena(contraseña);
        datosAccesoRepo.save(acceso);
        
        List<String> perfiles = new ArrayList<>();
        for(Integer rol:dto.getRoles()){
            var matchRol=rolRepo.findById(rol);
            if(matchRol.isEmpty()){
                registroEvento.log(INVALID_ROLE, APLICACION_ALTA_USUARIOS, hora, datos);
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Rol no existe");
            }
            perfiles.add(matchRol.get().getNombre());
            var perfPK = new PerfilPK(dto.getNumEmpleado(), dto.getCurp(), matchRol.get().getIdRol());
            var perf = new Perfil(perfPK,0);
            perfilRepo.save(perf);
        }
        registroEvento.log(USER_CREATE_SUCCESS, APLICACION_ALTA_USUARIOS, hora, datos);
        return new UsuarioResumenDTO(dto.getNumEmpleado(),
                                                                             dto.getNombre(),
                                                                          dto.getApellidoPaterno(),
                                                                        dto.getApellidoMaterno(),
                                                                        dto.getCorreoElectronico(),
                                                                         area.get().getNombre(),
                                                                 dto.getCurp(),
                                                                         perfiles,
                                                                        dto.getEstado()
        );
    }

    @Override
    @Transactional
    public UsuarioResumenDTO update(ActualizarUsuarioDTO dto, String token) {
        long hora= System.currentTimeMillis();
        //Clase donde guardaremos los DatosJSON
        record EventoDatos(ActualizarUsuarioDTO Actualizacion , SesionPK SesionActiva) {}
        String datos = null;
        try {
            // subjectJson tiene { nme, curp, hst, asi } tal como se emite en JwtService
            JwtSessionInfo info = objectMapper.readValue(token, JwtSessionInfo.class);
            var datosObj =new EventoDatos(dto, new SesionPK(info.getHoraInicio(),info.getNumEmpleado(), info.getCurp(), info.getAplicacionId()));
            datos=objectMapper.writeValueAsString(datosObj); 
           
        } catch (Exception e) {
            // Si el subject no se puede parsear, no podemos cerrar sesión
        }
        var usrMatch=usuarioRepo.findById(new UsuarioPK(dto.getNumEmpleado(), dto.getcurp()));
        if (usrMatch.isEmpty()){
            registroEvento.log(USER_PK_NOT_FOUND, APLICACION_ACTUALIZACION_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuario no existe");
        }
        //Verificar que no exista Correo en la BD
        var matchCorreoElectronico=usuarioRepo.findByCorreoElectronico(dto.getCorreoElectronico());
        if (matchCorreoElectronico.isPresent()){
            if(!matchCorreoElectronico.get().getUsuarioPK().equals(usrMatch.get().getUsuarioPK())){
            registroEvento.log(EMAIL_LINKED_TO_ANOTHER, APLICACION_ACTUALIZACION_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Correo vinculado a otro usuario");
            }
        }
        //Obtenemos Usuario para identificar al Usuario y editar
        var usr= usrMatch.get();
        var area = areaDeServicioRepo.findById(dto.getArea());
        if (area.isEmpty()){
            registroEvento.log(INVALID_AREA, APLICACION_ACTUALIZACION_USUARIOS, hora, datos);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Area no existe");
        }
        usr.setNombre(dto.getNombre());
        usr.setApellidoPaterno(dto.getApellidoPaterno());
        usr.setApellidoMaterno(dto.getApellidoMaterno());
        usr.setAreaidArea(area.get());
        usr.setCorreoElectronico(dto.getCorreoElectronico());
        usuarioRepo.save(usr);
        
        var edoAnterior=usr.getDatosAcceso().getEstado();
        System.out.println("\n\n\n\n\n"+edoAnterior);
        
        
        var acceso = usr.getDatosAcceso();
        acceso.setEstado(dto.getEstado());
        datosAccesoRepo.save(acceso);
        var edoNuevo=usrMatch.get().getDatosAcceso().getEstado();
        System.out.println(edoNuevo+usr.getDatosAcceso().getEstado()+"\n\n\n\n");
        
        List<String> perfiles= new ArrayList<>();
        //Borramos los Perfiles actuales
        List<Integer> perfilesNuevos= dto.getRoles();
        var perfilesActuales= perfilRepo.findByPerfilPKUsuarioNumEmpleadoAndPerfilPKUsuarioCURP(usr.getUsuarioPK().getNumEmpleado(), usr.getUsuarioPK().getCurp());
        for(Perfil perf:perfilesActuales){
            if(!perfilesNuevos.contains(perf.getRol().getIdRol())){
                perfilRepo.delete(perf);
            }else{
                perfiles.add(perf.getRol().getNombre());
                perfilesNuevos.remove(perf.getRol().getIdRol());
            }
        }
        
        for(Integer rol:perfilesNuevos){
            var matchRol=rolRepo.findById(rol);
            if(matchRol.isEmpty()){
                registroEvento.log(INVALID_ROLE, APLICACION_ACTUALIZACION_USUARIOS, hora, datos);
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Rol no existe");
            }
            perfiles.add(matchRol.get().getNombre());
            var perfPK = new PerfilPK(usr.getUsuarioPK().getNumEmpleado(), usr.getUsuarioPK().getCurp(), matchRol.get().getIdRol());
            var perf = new Perfil(perfPK,0);
            perfilRepo.save(perf);
        }
        
        //Analisis de Cambios de estado
        if (!edoAnterior.equals(dto.getEstado())){
            switch(dto.getEstado()){
                case "Bloqueado" -> registroEvento.log(USER_LOCKED_SUCCESS, APLICACION_ACTUALIZACION_USUARIOS, hora+1, datos);
                case "Dado de baja" -> registroEvento.log(USER_DEACTIVATE_SUCCESS, APLICACION_ACTUALIZACION_USUARIOS, hora+1, datos);
                default -> { if("Bloqueado".equals(edoAnterior)){registroEvento.log(USER_UNLOCKED_SUCCESS, APLICACION_ACTUALIZACION_USUARIOS, hora+1, datos);}}
            }
        }             
                          
        registroEvento.log(USER_UPDATE_SUCCESS, APLICACION_ACTUALIZACION_USUARIOS, hora, datos);
        return new UsuarioResumenDTO(
                usr.getUsuarioPK().getNumEmpleado(),
                usr.getNombre(),
                usr.getApellidoPaterno(),
                usr.getApellidoMaterno(),
                usr.getCorreoElectronico(),
                usr.getAreaidArea().getNombre(),
                usr.getUsuarioPK().getCurp(),
                perfiles,
                usr.getDatosAcceso().getEstado());
        
        
    }
    
    private UsuarioResumenDTO convertToResumenDTO(Usuario usuario) {
        List<String> roles = usuario.getPerfilCollection().stream().map(perfil -> perfil.getRol().getNombre()).collect(Collectors.toList());
    return new UsuarioResumenDTO(
        usuario.getUsuarioPK().getNumEmpleado(),
        usuario.getNombre(),
        usuario.getApellidoPaterno(),
        usuario.getApellidoMaterno(),
        usuario.getCorreoElectronico(),
        usuario.getAreaidArea().getNombre(),
        usuario.getUsuarioPK().getCurp(),
        roles,
        usuario.getDatosAcceso().getEstado()
        );
    }
    
}
