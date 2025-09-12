/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

/**
 *
 * @author vsfs2
 */
public class EquipoImagenologiaRequest {
    private String nSerie;
        private String nombreEquipo;
        private String marca;
        private String modelo;
        private String modalidad;
        private Integer idArea;
        private String estado; 
       

    public EquipoImagenologiaRequest(String nSerie, String nombreEquipo, String marca, String modelo, String modalidad, Integer idArea,String estado) {
        this.nSerie = nSerie;
        this.nombreEquipo = nombreEquipo;
        this.marca = marca;
        this.modelo = modelo;
        this.modalidad = modalidad;
        this.idArea = idArea;
        this.estado = estado;
        
    }
    
    public EquipoImagenologiaRequest(){
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
        
       
    public String getnSerie() {
        return nSerie;
    }

    public void setnSerie(String nSerie) {
        this.nSerie = nSerie;
    }

    public String getNombreEquipo() {
        return nombreEquipo;
    }

    public void setNombreEquipo(String nombreEquipo) {
        this.nombreEquipo = nombreEquipo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getModalidad() {
        return modalidad;
    }

    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }

    public Integer getIdArea() {
        return idArea;
    }

    public void setIdArea(Integer idArea) {
        this.idArea = idArea;
    }
    
}
