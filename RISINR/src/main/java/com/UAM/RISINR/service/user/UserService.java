package com.UAM.RISINR.service.user;

import java.util.List;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.ChangePswdDTO;
import com.UAM.RISINR.model.dto.userManager.ChangeMailDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;

/**
 * Interfaz de servicio para la gestión de usuarios en el sistema RISINR.
 * 
 * Esta interfaz define las operaciones de negocio relacionadas con la administración
 * de usuarios, incluyendo consultas, creación, actualización y cambios de correo y contraseña.
 * 
 * Todas las operaciones requieren un token de autenticación para validar los permisos
 * del usuario que realiza la acción.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface UserService {
    List<UsuarioResumenDTO> getAll(String token);
    UsuarioResumenDTO create(CrearUsuarioDTO dto, String token);
    UsuarioResumenDTO update(ActualizarUsuarioDTO dto, String token);
    void changePswd(ChangePswdDTO dto, String token);
    void changeMail(ChangeMailDTO dto, String token);
    UsuarioResumenDTO getUserSesion(String token);
}
