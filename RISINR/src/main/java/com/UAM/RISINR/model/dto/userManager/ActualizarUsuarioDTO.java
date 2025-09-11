package com.UAM.RISINR.model.dto.userManager;

import java.util.List;

public class ActualizarUsuarioDTO {
    private String curp;
    private Integer numEmpleado;
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String CorreoElectronico;
    private String estado;
    private Integer area;
    private List<Integer> roles;
    
    public ActualizarUsuarioDTO(){
    }
    
    public ActualizarUsuarioDTO(String curp, Integer numEmpleado, String nombre, String apellidoPaterno, String apellidoMaterno, String CorreoElectronico, String estado, Integer area, List<Integer> roles){
        this.curp=curp;
        this.numEmpleado=numEmpleado;
        this.nombre=nombre;
        this.apellidoPaterno=apellidoPaterno;
        this.apellidoMaterno=apellidoMaterno;
        this.CorreoElectronico=CorreoElectronico;
        this.estado=estado;
        this.area=area;
        this.roles=roles;
    } 
    
    public String getcurp(){
        return curp;
    }
    
    public void setcurp(String curp){
        this.curp = curp;
    }
    
    public Integer getNumEmpleado(){
        return numEmpleado;
    }    
    
    public void setNumEmpleado(Integer numEmpleado){
        this.numEmpleado=numEmpleado;
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
    
    public String getEstado(){
        return estado;
    }
    
    public void setEstado(String estado){
        this.estado=estado;
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
