/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.service.equipoImagenologia;

import com.UAM.RISINR.model.EquipoImagenologia;
import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaDTO;
import com.UAM.RISINR.model.dto.equipoImagenologia.EquipoImagenologiaRequest;
import java.util.List;

/**
 *
 * Interfaz que permite aislar la implementación de la lógica de negocio
 * del servicio de equipos. Declara los métodos CRUD para el servicio.
 * 
 * Spring se encarga de encontrar la clase que implemente la interfaz. 
 */
public interface EquipoImagenologiaService {
    
    List<EquipoImagenologiaDTO> consultarTodos(String token);
    EquipoImagenologiaDTO add(EquipoImagenologiaRequest equipoRequest);
    EquipoImagenologiaDTO  edit(EquipoImagenologiaRequest equipoRequest);
    EquipoImagenologiaDTO convertirDTO(EquipoImagenologia eqp);
}
