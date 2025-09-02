package com.UAM.RISINR.model.dto.shared;

public class UsuarioDTO {
    private int numEmpleado;
    private String curp;
    private int area_idArea;
    private String nombre;        
    private String apellidoPaterno; 
    private String apellidoMaterno; 

    public UsuarioDTO() {
    }

    public UsuarioDTO(int numEmpleado, String curp, int area_idArea, String nombre, String apellidoPaterno, String apellidoMaterno) {
        this.nombre                = nombre;
        this.apellidoPaterno  = apellidoPaterno;
        this.apellidoMaterno = apellidoMaterno;
        this.numEmpleado    = numEmpleado;
        this.curp                      = curp;
        this.area_idArea         = area_idArea;
    }

    public int getnumEmpleado() {
        return numEmpleado; 
    }
    
    public void setnumEmpleado(int numEmpleado ) { 
        this.numEmpleado =numEmpleado ; 
    }

    public String getcurp() {
        return curp; 
    }
    
    public void setcurp(String curp ) { 
        this.curp = curp; 
    }

    public int getarea_idArea() {
        return area_idArea; 
    }
    
    public void setarea_idArea( int area_idArea) { 
        this.area_idArea = area_idArea; 
    }

    public String getNombre() { 
        return nombre; 
    }
    
    public void setNombre(String nombre) { 
        this.nombre = nombre; 
    }

    public String getApellidoPaterno() {
        return apellidoPaterno; 
    }
    
    public void setApellidoPaterno(String apellidoPaterno) { 
        this.apellidoPaterno = apellidoPaterno; 
    }

    public String getApellidoMaterno() { 
        return apellidoMaterno; 
    }
    public void setApellidoMaterno(String apellidoMaterno) { 
        this.apellidoMaterno = apellidoMaterno; 
    }
}