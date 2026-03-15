package com.UAM.RISINR.model.dto.citas;

public class SalaDTO {
    private String ubicacion;
    
    public SalaDTO() {
    }
    
    public SalaDTO(String ubicacion) {
        this.ubicacion = ubicacion;
    }
 
    public String getUbicacion() {
        return ubicacion;
    }
    
    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }
}
