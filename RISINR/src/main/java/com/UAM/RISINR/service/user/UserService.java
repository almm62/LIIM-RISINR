package com.UAM.RISINR.service.user;

import java.util.List;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.ChangePswdDTO;
import com.UAM.RISINR.model.dto.userManager.ChangeMailDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;

public interface UserService {
    List<UsuarioResumenDTO> getAll(String token);
    UsuarioResumenDTO create(CrearUsuarioDTO dto, String token);
    UsuarioResumenDTO update(ActualizarUsuarioDTO dto, String token);
    void changePswd(ChangePswdDTO dto, String token);
    void changeMail(ChangeMailDTO dto, String token);
    UsuarioResumenDTO getUserSesion(String token);
}
