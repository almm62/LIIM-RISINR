/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.UAM.RISINR.service.areaDeServicio;

import com.UAM.RISINR.model.AreaDeServicio;

/**
 * Interfaz del servicio de áreas de servicio.
 * 
 * Define las operaciones disponibles para la gestión de áreas de servicio,
 * principalmente la consulta de un área a partir de su identificador.
 * 
 * Esta interfaz permite abstraer la implementación concreta, facilitando
 * la inyección de dependencias y pruebas unitarias.
 * 
 * Autor: Maria de Jesus Rebolledo Bustillo
 */
public interface AreaDeServicioService {
        AreaDeServicio consultarPorID(Integer id); 
}
