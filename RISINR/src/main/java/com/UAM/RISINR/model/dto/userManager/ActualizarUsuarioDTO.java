package com.UAM.RISINR.model.dto.userManager;

import java.util.List;

public class ActualizarUsuarioDTO {
    private String UsuarioID; // Solo para identificar, no tiene Setter
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String CorreoElectronico;
    private Integer area;
    private List<Integer> roles;
    
    public ActualizarUsuarioDTO(){
    }
    
    public ActualizarUsuarioDTO(String UsuarioID, String nombre, String apellidoPaterno, String apellidoMaterno, String CorreoElectronico, Integer area, List<Integer> roles){
        this.UsuarioID=UsuarioID;
        this.nombre=nombre;
        this.apellidoPaterno=apellidoPaterno;
        this.apellidoMaterno=apellidoMaterno;
        this.CorreoElectronico=CorreoElectronico;
        this.area=area;
        this.roles=roles;
    } 
    
    public String getUsuarioID(){
        return UsuarioID;
    }
    
    public void setUsuarioID(String UsuarioID){
        this.UsuarioID = UsuarioID;
    }
    
    public String getNombre(){
        return nombre;
    }
    public void setNombre(String nombre){
        this.nombre=nombre;
    }
    
    public String getApellidoPaterno(){
        return apellidoPaterno;
    }
    public void setApellidoPaterno(String apellidoPaterno){
        this.apellidoPaterno=apellidoPaterno;
    }
    
    public String getApellidoMaterno(){
        return apellidoMaterno;
    }
    public void setApellidoMaterno(String apellidoMaterno){
        this.apellidoMaterno=apellidoMaterno;
    }
    
    public String getCorreoElectronico(){
        return CorreoElectronico;
    }
    public void setCorreoElectronico(String CorreoElectronico){
        this.CorreoElectronico=CorreoElectronico;
    }
    
    public Integer getArea(){
        return area;
    }
    public void setArea(Integer area){
        this.area=area;
    }
    
    public List<Integer> getRoles(){
        return roles;
    }
    public void setRoles(List<Integer> roles){
        this.roles=roles;
    }
}
