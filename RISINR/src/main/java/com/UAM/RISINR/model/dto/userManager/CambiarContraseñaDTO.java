package com.UAM.RISINR.model.dto.userManager;

public class CambiarContraseñaDTO {
    private String usuarioID;
    private String contrasñea;
    
       public CambiarContraseñaDTO(){
    }
    
    public CambiarContraseñaDTO(String usuarioID, String contrasñea){
        this.usuarioID=usuarioID;
        this.contrasñea=contrasñea;
    } 
    
    
    public String getUsuarioID(){
        return usuarioID;
    }
    public void setUsuarioID(String usuarioID){
        this.usuarioID=usuarioID;
    }
    
    public String getContraseña(){
        return contrasñea;
    }
    public void setContraseña(String contrasñea){
        this.contrasñea=contrasñea;
    }
}
