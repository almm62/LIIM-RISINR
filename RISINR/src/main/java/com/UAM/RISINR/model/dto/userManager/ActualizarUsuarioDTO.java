package com.UAM.RISINR.model.dto.userManager;

import java.util.List;

public class ActualizarUsuarioDTO {
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String curp;
    private Integer area;
    private List<Integer> roles;
    
    public ActualizarUsuarioDTO(){
    }
    
    public ActualizarUsuarioDTO(String nombre, String apellidoPaterno, String apellidoMaterno, String curp, Integer area, List<Integer> roles){
        this.nombre=nombre;
        this.apellidoPaterno=apellidoPaterno;
        this.apellidoMaterno=apellidoMaterno;
        this.curp=curp;
        this.area=area;
        this.roles=roles;
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
    
    public String getCurp(){
        return curp;
    }
    public void setCurp( String curp){
        this.curp=curp;
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
