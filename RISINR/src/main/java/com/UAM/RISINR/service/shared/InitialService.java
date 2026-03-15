package com.UAM.RISINR.service.shared;

import java.util.List;

/**
 * Interfaz del servicio de datos iniciales. Provee las listas de áreas de servicio
 * y roles disponibles en el sistema, serializadas como cadenas JSON.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface InitialService {
    /**
     * Retorna la lista de todas las áreas de servicio serializadas como cadenas JSON.
     * @return Lista de cadenas JSON, una por cada AreaDeServicio registrada
     */
    List<String> getAreas();
    /**
     * Retorna la lista de todos los roles disponibles serializados como cadenas JSON.
     * @return Lista de cadenas JSON, una por cada Rol registrado
     */
    List<String> getRoles();
}
