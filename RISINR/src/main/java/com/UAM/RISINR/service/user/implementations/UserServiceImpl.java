package com.UAM.RISINR.service.user.implementations;

import com.UAM.RISINR.model.DatosAcceso;
import com.UAM.RISINR.model.DatosAccesoPK;
import com.UAM.RISINR.model.Usuario;
import com.UAM.RISINR.model.UsuarioPK;
import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.DatosAccesoRepository;
import com.UAM.RISINR.repository.PerfilRepository;
import com.UAM.RISINR.repository.RolRepository;
import com.UAM.RISINR.repository.UsuarioRepository;
import com.UAM.RISINR.service.user.UserService;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
public class UserServiceImpl implements UserService{
    private final UsuarioRepository usuarioRepo;
    private final DatosAccesoRepository datosAccesoRepo;
    private final AreaDeServicioRepository areaDeServicioRepo;
    private final PerfilRepository perfilRepo;
    private final RolRepository rolRepo;
    
    
public UserServiceImpl(UsuarioRepository usuarioRepo, DatosAccesoRepository datosAccesoRepo, AreaDeServicioRepository areaDeServicioRepo, PerfilRepository perfilRepo, RolRepository rolRepo){
    this.areaDeServicioRepo=areaDeServicioRepo;
    this.usuarioRepo=usuarioRepo;
    this.datosAccesoRepo=datosAccesoRepo;
    this.perfilRepo=perfilRepo;
    this.rolRepo= rolRepo;
    }

    @Override
    @Transactional
    public List<UsuarioResumenDTO> getAll() {
        var usuarios= usuarioRepo.findAll();
        return usuarios.stream()
            .map(this::convertToResumenDTO)
            .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public UsuarioResumenDTO create(CrearUsuarioDTO dto, String ipDispositivo) {
        String ip15=normalizarIp(ipDispositivo);
        //Verificar que no exista UsuarioPK en la BD
        var usrPK = new UsuarioPK(dto.getNumEmpleado(),
                                                                        dto.getCurp());
        var matchUsuarioPK=usuarioRepo.findById(usrPK);
        if (matchUsuarioPK.isPresent()){
            throw new ResponseStatusException(HttpStatus.CONFLICT, "UsuarioPK ya existente");
        }
        //Verificar que no exista Correo en la BD
        var matchCorreoElectronico=usuarioRepo.findByCorreoElectronico(dto.getCorreoElectronico());
        if (matchCorreoElectronico.isPresent()){
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Correo vinculado a otro usuario");
        }
        //Verificar que no exista UsuarioID en la BD
        var matchID=datosAccesoRepo.findByIdUsuarioID(dto.getUsuarioID());
        if (matchID.isPresent()){
            throw new ResponseStatusException(HttpStatus.CONFLICT, "UsuarioID ya existente");
        }
        var area=areaDeServicioRepo.findById(dto.getArea());
        
        Usuario usr = new Usuario();
        usr.setUsuarioPK(usrPK);
        usr.setNombre(dto.getNombre());
        usr.setApellidoPaterno(dto.getApellidoPaterno());
        usr.setApellidoMaterno(dto.getApellidoMaterno());
        usr.setAreaidArea(area.get());
        usr.setCorreoElectronico(dto.getCorreoElectronico());
        
        var accesoPK = new DatosAccesoPK(dto.getUsuarioID(),
                                                                                dto.getNumEmpleado(),
                                                                                dto.getCurp());
        var contraseña=dto.getCurp(); //Contraseña = curp, Al rpimer Login se le obliga a cambiar
        
        var acceso = new DatosAcceso();
        acceso.setId(accesoPK);
        acceso.setContrasena(ip15);
        acceso.setEstado("Activo");
        acceso.setContrasena(contraseña);
        
        for(Integer rol:dto.getRoles()){
            rolRepo.findById(rol);
         
        }
        
        
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    @Transactional
    public void update(ActualizarUsuarioDTO dto, String ipDispositivo) {
        
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
    private String normalizarIp(String ip) {
        if (ip == null) return null;
        // Columna VARCHAR(15) → IPv4
        return (ip.length() > 15) ? ip.substring(0, 15) : ip;
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
        roles
        );
    }
    
}
