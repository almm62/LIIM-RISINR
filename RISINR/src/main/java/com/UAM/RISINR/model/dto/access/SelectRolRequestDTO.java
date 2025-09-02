package com.UAM.RISINR.model.dto.access;

public class SelectRolRequestDTO {

    private String usuarioId;  
    private Integer idRol;     

    public SelectRolRequestDTO() {
    }

    public SelectRolRequestDTO(String usuarioId, Integer idRol) {
        this.usuarioId = usuarioId;
        this.idRol = idRol;
    }

    public String getUsuarioId() {
        return usuarioId; 
    }
    
    public void setUsuarioId(String usuarioId) {
        this.usuarioId = usuarioId; 
    }

    public Integer getIdRol() { 
        return idRol; 
    }
    public void setIdRol(Integer idRol) { 
        this.idRol = idRol; 
    }
}