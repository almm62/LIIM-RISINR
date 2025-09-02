package com.UAM.RISINR.model.dto.shared;

public class AreaDTO {

    private Integer idArea;
    private String nombreArea;   // nomrbeArea en lugar de nombre Para mantener coherencia con EquipoImagenologiaDTO
    private String descripcion;

    public AreaDTO() {
    }

    public AreaDTO(Integer idArea, String nombreArea, String descripcion) {
        this.idArea = idArea;
        this.nombreArea = nombreArea;
        this.descripcion = descripcion;
    }

    public Integer getIdArea() {
        return idArea;
    }

    public void setIdArea(Integer idArea) {
        this.idArea = idArea;
    }

    public String getNombreArea() {
        return nombreArea;
    }

    public void setNombreArea(String nombreArea) {
        this.nombreArea = nombreArea;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
