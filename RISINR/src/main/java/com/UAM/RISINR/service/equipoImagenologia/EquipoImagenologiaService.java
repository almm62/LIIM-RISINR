/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.service.equipoImagenologia;

import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.EquipoImagenologiaDTO;
import java.util.List;
import java.util.Map;

/**
 *
 * @author vsfs2
 */
public interface EquipoImagenologiaService {
    
    List<EquipoImagenologiaDTO> consultarTodos();
    EquipoImagenologiaDTO add(EquipoImagenologiaDTO equipoDTO);
    EquipoImagenologiaDTO  edit(Map<String, String> formData);
    EquipoImagenologiaDTO convertirDTO(EquipoImagenologia eqp);
    
}
