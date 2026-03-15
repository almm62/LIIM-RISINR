package com.UAM.RISINR.service.access.implementations;

import com.UAM.RISINR.model.Sesion;
import com.UAM.RISINR.model.SesionPK;
import com.UAM.RISINR.model.dto.access.LoginRequestDTO;
import com.UAM.RISINR.model.dto.access.LoginResponseDTO;
import com.UAM.RISINR.model.dto.access.SelectRolRequestDTO;
import com.UAM.RISINR.model.dto.shared.UsuarioDTO;
import com.UAM.RISINR.model.dto.shared.AreaDTO;
import com.UAM.RISINR.model.dto.shared.RolDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.DatosAccesoRepository;
import com.UAM.RISINR.repository.PerfilRepository;
import com.UAM.RISINR.repository.RegistroEventoRepository;
import com.UAM.RISINR.repository.RolRepository;
import com.UAM.RISINR.repository.SesionRepository;
import com.UAM.RISINR.repository.projection.RolView;
import com.UAM.RISINR.service.access.AccessService;
import com.UAM.RISINR.service.access.AccountLockedService;
import com.UAM.RISINR.service.shared.JwtService;
import com.UAM.RISINR.service.model.JwtSessionInfo;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.math.BigInteger;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Servicio de autenticación y gestión de sesiones.
 * 
 * Este servicio implementa la lógica de negocio para:
 * - Autenticación de usuarios mediante usuario y contraseña
 * - Gestión de múltiples roles por usuario
 * - Creación y cierre de sesiones
 * - Bloqueo automático de cuentas tras intentos fallidos
 * - Registro de eventos de seguridad
 * - Cierre de sesión
 * 
 * @author Pedro Misael Rodríguez Jiménez
 * 
 */
@Service
public class AccessServiceImpl implements AccessService {
    private final RegistroEventoRepository registroEventoRepo;
    private final AccountLockedService blockAccount;
    private final RegistroEventoService registroEvento;
    private final DatosAccesoRepository accesoRepo;
    private final PerfilRepository perfilRepo;
    private final RolRepository rolRepo;
    private final AreaDeServicioRepository areaRepo;
    private final SesionRepository sesionRepo;
    private final JwtService jwtService;
    private final ObjectMapper objectMapper;
    private String datos;

    private static final int EVENTO_LOGIN_EXITOSO = 1;     // "Login Exitoso"
    private static final int EVENTO_BLOQUEO_DE_USUARIO = 2;//"Cambio de Estado='Activo' -> Estado='Bloqueado'
    private static final int EVENTO_PWD_INCORRECTA = 1001; // "Contraseña Incorrecta en Login"
    private static final int EVENTO_USUARIO_INVALIDO = 1002; // "Usuario invalido"
    private static final int EVENTO_USUARIO_BLOQUEADO = 1003;//"Usuario con estado!=Activo"
    
    // Aplicación que registra el evento
    private static final int APLICACION_ID = 0;


    /**
     * Constructor con inyección de dependencias.
     * 
     * @param accesoRepo Repositorio de credenciales de usuario
     * @param perfilRepo Repositorio de perfiles usuario-rol
     * @param rolRepo Repositorio de roles
     * @param areaRepo Repositorio de áreas
     * @param sesionRepo Repositorio de sesiones
     * @param registroEventoRepo Repositorio de eventos de seguridad
     * @param jwtService Servicio de generación y validación de tokens JWT
     * @param blockAccount Servicio de bloqueo de cuentas
     * @param registroEvento Servicio de registro de eventos
     * @param objectMapper Mapper para serialización JSON
     */
    public AccessServiceImpl(RegistroEventoRepository registroEventoRepo,
                             RegistroEventoService registroEvento,
                             AccountLockedService blockAccount,
                             DatosAccesoRepository accesoRepo,
                             PerfilRepository perfilRepo,
                             RolRepository rolRepo,
                             AreaDeServicioRepository areaRepo,
                             SesionRepository sesionRepo,
                             JwtService jwtService,
                             ObjectMapper objectMapper) {
        this.registroEventoRepo=registroEventoRepo;
        this.blockAccount=blockAccount;
        this.registroEvento = registroEvento;
        this.accesoRepo=accesoRepo;
        this.perfilRepo = perfilRepo;
        this.rolRepo = rolRepo;
        this.areaRepo = areaRepo;
        this.sesionRepo = sesionRepo;
        this.jwtService = jwtService;
        this.objectMapper = objectMapper;
    }

    /**
     * Procesa el inicio de sesión de un usuario.
     * 
     * Flujo del método:
     * 1. Valida credenciales (usuario/contraseña)
     * 2. Verifica estado de la cuenta (activa/bloqueada)
     * 3. Implementa protección contra fuerza bruta (máximo 5 intentos en 15 min)
     * 4. Obtiene información del usuario, área y roles
     * 5. Si el usuario tiene un solo rol: crea sesión y genera token
     * 6. Si tiene múltiples roles: requiere selección posterior
     * 
     * @param request Objeto con credenciales (usuario y contraseña)
     * @param ipDispositivo Dirección IP del cliente
     * @return LoginResponseDTO con información del usuario, área, roles y token (si aplica)
     * @throws ResponseStatusException Si las credenciales son inválidas, la cuenta está bloqueada,
     *         o no hay roles asignados
     */
    @Override
    @Transactional
    public LoginResponseDTO login(LoginRequestDTO request, String ipDispositivo) {
        long hora= System.currentTimeMillis();
        long umbralBloqueo=hora-900000; //15 Minutos.
        String ip15 = normalizarIp(ipDispositivo);
        record EventoDatos(String usuarioId, String contrasena, String ipAddress) {}
        var datosObj = new EventoDatos(request.getUsuario(), request.getContrasena(), ip15);
        try {
            datos=objectMapper.writeValueAsString(datosObj); // JSON correcto
        } catch (JsonProcessingException e) {
            e.printStackTrace(); 
            datos = "{}"; // valor por defecto para no romper la app
        }
        // 1) Autenticar 
        var match = accesoRepo.findByIdUsuarioID(request.getUsuario());// Regresa List con datos de usuarios con coincidencias en ID + Contraseñas

        if (!match.isPresent()) {
            registroEvento.log(EVENTO_USUARIO_INVALIDO,APLICACION_ID, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "USER_INVALID");
        }
        if (!"Activo".equals(match.get().getEstado()) && !"Inicial".equals(match.get().getEstado())){
            registroEvento.log(EVENTO_USUARIO_BLOQUEADO, APLICACION_ID, hora, datos);
            throw new ResponseStatusException(HttpStatus.LOCKED, "USER_LOCKED");
        }
        if (!match.get().getContrasena().equals(request.getContrasena())){
            
            //Cuenta los Intentos fallidos con mismo UsuarioID e ipAddress en ultimos 15 minutos
            var conteo=0;
            var matches=registroEventoRepo.findByIdEventoIdAndIdHoraEventoGreaterThanEqual(EVENTO_PWD_INCORRECTA, umbralBloqueo);
            for (var it : matches){
                try {
                    var json = objectMapper.readTree(it.getDatos());
                    if (request.getUsuario().equals(json.path("usuarioId").asText(null)) &&
                            ip15.equals(json.path("ipAddress").asText(null))) {
                        conteo++;
                    }
                    if (conteo>=4){
                        blockAccount.block(request.getUsuario());
                        registroEvento.log(EVENTO_BLOQUEO_DE_USUARIO, APLICACION_ID, hora+1, datos);
                        break;
                    }
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
            }
            registroEvento.log(EVENTO_PWD_INCORRECTA, APLICACION_ID, hora, datos);
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "PASSWORD_INVALID");
        }

        // 2) Usuario resumen (Util para saludar)
        var usuario = new UsuarioDTO(
                                         match.get().getId().getUsuarioNumEmpleado(),
                                          match.get().getId().getUsuarioCURP(),
                                         match.get().getUsuario().getAreaidArea().getIdArea(),
                                         match.get().getUsuario().getNombre(),
                                         match.get().getUsuario().getApellidoPaterno(),
                                        match.get().getUsuario().getApellidoMaterno());
        

        // 3) Área
        Integer areaId = usuario.getarea_idArea();
        AreaDTO area = areaRepo.findById(areaId)
                .map(a -> new AreaDTO(a.getIdArea(), a.getNombre(), a.getDescripcion()))
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.INTERNAL_SERVER_ERROR,
                        "El área asociada al usuario no existe (id=" + areaId + ").")
                );

        // 4) Roles: ids/estado (Perfil) → detalle (Rol)
        var perfiles = perfilRepo.findByPerfilPKUsuarioNumEmpleadoAndPerfilPKUsuarioCURP(usuario.getnumEmpleado(), usuario.getcurp()); //List con Perfiles del usuario
        if (perfiles.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "El usuario no tiene roles asignados");
        }
        List<Integer> rolIds = perfiles.stream()
        .map(p -> p.getPerfilPK().getRolidRol())
        .toList();
        var rolRows = rolRepo.findByIdRolIn(rolIds);
        Map<Integer, RolView> byId = new LinkedHashMap<>();
        rolRows.forEach(r -> byId.put(r.getIdRol(), r));

        List<RolDTO> roles = new ArrayList<>();
        for (Integer id : rolIds) {
            var r = byId.get(id);
            if (r != null) {
                roles.add(new RolDTO(r.getIdRol(), r.getNombre(), r.getDescripcion()));
            }
        }

        // 5) 1 rol → crear sesión + token; >1 → requiere selección
        if (roles.size() == 1) {
            RolDTO unico = roles.get(0);

            
            var spk = new SesionPK(
                    hora,
                    usuario.getnumEmpleado(),
                    usuario.getcurp(),
                    APLICACION_ID
            );
            var sesion = new Sesion(spk, ip15, match.get().getId().getUsuarioID());
            sesion.setRolNombre(unico.getNombre());
            sesionRepo.save(sesion);

            String token = jwtService.emitirToken(usuario.getnumEmpleado(),
                    usuario.getcurp(),
                    hora,
                    APLICACION_ID
            );
            registroEvento.log(EVENTO_LOGIN_EXITOSO, APLICACION_ID, hora, datos);

            // Opción 1: 'roles' solo con el elegido
            return new LoginResponseDTO(usuario, area, List.of(unico), token, false);
        } else {
            // varios roles → sin sesión ni token
            return new LoginResponseDTO(usuario, area, roles, null, true);
        }
    }

    /**
     * Procesa la selección de rol cuando un usuario tiene múltiples roles disponibles.
     * 
     * Este método se invoca después de un login exitoso cuando el usuario debe elegir
     * con qué rol desea trabajar en la sesión actual.
     * 
     * Flujo del método:
     * 1. Valida los datos de entrada
     * 2. Verifica la existencia del usuario
     * 3. Valida que el usuario tenga un área asignada
     * 4. Verifica que el rol elegido exista
     * 5. Crea la sesión con el rol seleccionado
     * 6. Genera el token JWT
     * 
     * @param request Objeto con el ID de usuario y el ID del rol seleccionado
     * @param ipDispositivo Dirección IP del cliente
     * @return LoginResponseDTO con información del usuario, área, rol elegido y token
     * @throws ResponseStatusException Si hay errores de validación o el rol no existe
     */
    @Override
    @Transactional
    public LoginResponseDTO seleccionarRol(SelectRolRequestDTO request, String ipDispositivo) {

        // 0) Validaciones de entrada básicas
        if (request == null || request.getUsuarioId() == null || request.getUsuarioId().isBlank()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Usuario requerido.");
        }
        if (request.getIdRol() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "rolId requerido.");
        }

        // 1) Ubicar al usuario por su UsuarioID (SIN contraseña en este paso)
        //    Esperamos 0, 1 
        var usuario = accesoRepo.findByIdUsuarioID(request.getUsuarioId());

        // 2) Área OBLIGATORIA
        Integer areaId = usuario.get().getUsuario().getAreaidArea().getIdArea();
        if (areaId == null) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "El usuario no tiene área asignada.");
        }
        AreaDTO area = areaRepo.findById(areaId)
                .map(a -> new AreaDTO(a.getIdArea(), a.getNombre(), a.getDescripcion()))
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.INTERNAL_SERVER_ERROR,
                        "El área asociada al usuario no existe (id=" + areaId + ").")
                );

        // 3) Obtener el detalle del rol elegido (nombre/descripcion) — usando la proyección que ya tienes
        List<RolView> rolRows = rolRepo.findByIdRolIn(List.of(request.getIdRol()));
        if (rolRows.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "El rol elegido no existe.");
        }
        RolView r = rolRows.get(0);
        RolDTO rolElegido = new RolDTO(r.getIdRol(), r.getNombre(), r.getDescripcion());

        // 4) Crear Sesión (PK SIN UsuarioID) y emitir token
        long horaInicio = System.currentTimeMillis();
        String ip15 = normalizarIp(ipDispositivo);

        SesionPK spk = new SesionPK(
                horaInicio,
                usuario.get().getId().getUsuarioNumEmpleado(),
                usuario.get().getId().getUsuarioCURP(),
                APLICACION_ID
        );

        String token = jwtService.emitirToken(
                usuario.get().getId().getUsuarioNumEmpleado(),
                usuario.get().getId().getUsuarioCURP(),
                horaInicio,
                APLICACION_ID
        );

        Sesion sesion = new Sesion(spk, ip15, usuario.get().getId().getUsuarioID());
        sesion.setRolNombre(rolElegido.getNombre());
        sesionRepo.save(sesion);
        registroEvento.log(EVENTO_LOGIN_EXITOSO, APLICACION_ID, horaInicio, datos);
        // 5) Usuario en respuesta (mismo criterio que en login)
        var usuariodto = new UsuarioDTO(
                                         usuario.get().getId().getUsuarioNumEmpleado(),
                                          usuario.get().getId().getUsuarioCURP(),
                                         usuario.get().getUsuario().getAreaidArea().getIdArea(),
                                         usuario.get().getUsuario().getNombre(),
                                         usuario.get().getUsuario().getApellidoPaterno(),
                                        usuario.get().getUsuario().getApellidoMaterno());

        // 6) Responder con SOLO el rol elegido y requiereSeleccionRol=false
        return new LoginResponseDTO(usuariodto, area, List.of(rolElegido), token, false);
    }
    
    /**
     * Cierra la sesión de un usuario actualizando el registro en la base de datos.
     * 
     * Este método marca el fin de una sesión activa, registrando la hora de finalización
     * y el tipo de cierre (normal, timeout, etc.).
     * 
     * @param subjectJson String JSON con la información de la sesión extraída del token JWT.
     *                    Debe contener: numEmpleado, curp, horaInicio y aplicacionId
     * @param tipoCierre Tipo de cierre de sesión (ej: "NORMAL", "TIMEOUT")
     */
    @Override
    @Transactional
    public void logout(String subjectJson, String tipoCierre) {
        try {
            // subjectJson tiene { nme, curp, hst, asi } tal como se emite en JwtService
            JwtSessionInfo info = objectMapper.readValue(subjectJson, JwtSessionInfo.class);

            // Construir la PK EXACTA al hacer login
            SesionPK pk = new SesionPK(
                    info.getHoraInicio(),
                    info.getNumEmpleado(),
                    info.getCurp(),
                    info.getAplicacionId()
            );

            var sesionOpt = sesionRepo.findById(pk);
            if (sesionOpt.isEmpty()) {
                return;
            }

            var sesion = sesionOpt.get();
            sesion.setHoraFin(BigInteger.valueOf(System.currentTimeMillis()));
            sesion.setTipoCierre(normalizarTipoCierre(tipoCierre));
            sesionRepo.save(sesion);

        } catch (Exception e) {
            // Si el subject no se puede parsear, no podemos cerrar sesión
        }
    }
    
    
    /**
     * Metodo auxiliar para normalizar una dirección IP para que 
     * cumpla con el límite de la base de datos.
     * 
     * La columna de IP en la base de datos es VARCHAR(15), lo cual es suficiente
     * para direcciones IPv4 pero puede ser insuficiente para IPv6. Este método
     * trunca la IP si excede el límite.
     * 
     * @param ip Dirección IP a normalizar
     * @return IP normalizada (máximo 15 caracteres) o null si la entrada es null
     */
    private String normalizarIp(String ip) {
        if (ip == null) return null;
        // Columna VARCHAR(15) → IPv4
        return (ip.length() > 15) ? ip.substring(0, 15) : ip;
    }
    
    /**
     * Metodo auxiliar par normalizar el tipo de cierre de sesión para cumplir con límites de base de datos.
     * 
     * La columna tipoCierre es VARCHAR(25). Este método limpia y trunca el valor
     * si es necesario.
     * 
     * @param tc Tipo de cierre a normalizar
     * @return Tipo de cierre normalizado (máximo 25 caracteres) o null si la entrada es null
     */
    private String normalizarTipoCierre(String tc) {
        if (tc == null) return null;
        // Columna VARCHAR(25)
        tc = tc.trim();
        return tc.length() > 25 ? tc.substring(0, 25) : tc;
}
}