package com.UAM.RISINR.model.dto.citas;

public class SalaDTO {
    private String ubicacion;
    private String sala;
    
    public SalaDTO() {
    }
    
    public SalaDTO(String ubicacion, String sala) {
        this.ubicacion = ubicacion;
        this.sala = sala;
    }
 
    public String getUbicacion() {
        return ubicacion;
    }
    
    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }
    
    public String getSala() {
        return sala;
    }
    
    public void setSala(String sala) {
        this.sala = sala;
    }
}
