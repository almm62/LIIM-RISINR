package com.UAM.RISINR.service.user;

import com.UAM.RISINR.model.dto.userManager.ActualizarUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.CrearUsuarioDTO;
import com.UAM.RISINR.model.dto.userManager.UsuarioResumenDTO;
import java.util.List;

public interface UserService {
    List<UsuarioResumenDTO> getAll(String token);
    UsuarioResumenDTO create(CrearUsuarioDTO dto, String token);
    UsuarioResumenDTO update(ActualizarUsuarioDTO dto, String token);
}
