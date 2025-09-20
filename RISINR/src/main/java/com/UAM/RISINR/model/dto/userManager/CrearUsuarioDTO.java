package com.UAM.RISINR.model.dto.userManager;

import java.util.List;


public class CrearUsuarioDTO {
    private String UsuarioID; // Campo por agregar al formulario
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String CorreoElectronico;
    private String curp;
    private Integer numEmpleado; // Agregar al formulario pendiente
    private Integer area;
    private List<Integer> roles;
    private String Estado;
    
    public CrearUsuarioDTO(){
    }
    
    public CrearUsuarioDTO(String UsuarioID, String nombre, String apellidoPaterno, String apellidoMaterno,
                                                     String CorreoElectronico, String curp, Integer numEmpleado, Integer area, 
                                                     List<Integer> roles, String Estado){
        this.UsuarioID=UsuarioID;
        this.nombre=nombre;
        this.apellidoPaterno=apellidoPaterno;
        this.apellidoMaterno=apellidoMaterno;
        this.CorreoElectronico=CorreoElectronico;
        this.curp=curp;
        this.numEmpleado=numEmpleado;
        this.area=area;
        this.roles=roles;
        this.Estado=Estado;
    } 
    
    public String getUsuarioID(){
        return UsuarioID;
    }
    public void setUsuarioID(String UsuarioID){
        this.UsuarioID=UsuarioID;
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
    
    public String getCurp(){
        return curp;
    }
    public void setCurp( String curp){
        this.curp=curp;
    }
    
    public Integer getNumEmpleado(){
        return numEmpleado;
    }
    public void setNumEmpleado(Integer numEmpleado){
        this.numEmpleado=numEmpleado;
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
    
    public String getEstado(){
        return Estado;
    }
    public void setEstado(String Estado){
        this.Estado=Estado;
    }
}
