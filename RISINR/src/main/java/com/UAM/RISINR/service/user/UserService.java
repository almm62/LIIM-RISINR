package com.UAM.RISINR.service.user;

import java.util.List;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.ChangePswdDTO;
import com.UAM.RISINR.model.dto.userManager.ChangeMailDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;

/**
 * Interfaz de servicio para la gestión de usuarios en el sistema RISINR.
 * Define las operaciones de creación, consulta, actualización y cambios de correo
 * y contraseña. Todas las operaciones requieren un token de autenticación.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface UserService {
    /**
     * Retorna el resumen de todos los usuarios; si el rol en sesión es JefedelServicio,
     * filtra por el área del usuario autenticado.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return Lista de UsuarioResumenDTO con los usuarios visibles para el rol en sesión
     */
    List<UsuarioResumenDTO> getAll(String token);
    /**
     * Crea un nuevo usuario en el sistema junto con sus datos de acceso y perfiles de rol.
     * @param dto Datos del usuario a crear
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return UsuarioResumenDTO con la información del usuario recién creado
     */
    UsuarioResumenDTO create(CrearUsuarioDTO dto, String token);
    /**
     * Actualiza los datos de un usuario existente, incluyendo área, correo, estado y roles.
     * @param dto Datos actualizados del usuario
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return UsuarioResumenDTO con la información del usuario actualizado
     */
    UsuarioResumenDTO update(ActualizarUsuarioDTO dto, String token);
    /**
     * Cambia la contraseña del usuario autenticado, validando la contraseña actual.
     * @param dto Contraseña actual y la nueva contraseña (dos veces para confirmación)
     * @param token JSON del subject JWT con datos de la sesión activa
     */
    void changePswd(ChangePswdDTO dto, String token);
    /**
     * Cambia el correo electrónico del usuario autenticado, validando la contraseña actual.
     * @param dto Correo nuevo (dos veces para confirmación) y contraseña actual
     * @param token JSON del subject JWT con datos de la sesión activa
     */
    void changeMail(ChangeMailDTO dto, String token);
    /**
     * Retorna el resumen del usuario dueño de la sesión activa.
     * @param token JSON del subject JWT con datos de la sesión activa
     * @return UsuarioResumenDTO con los datos del usuario autenticado
     */
    UsuarioResumenDTO getUserSesion(String token);
}
