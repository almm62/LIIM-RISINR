package com.UAM.RISINR.model.dto.userManager;

import java.util.List;

//Contiene informacion necesaria para desplegar en la tabla (Gestion de Usuarios)
public class UsuarioResumenDTO {
    private int NumEmpleado;
    private String Nombre;
    private String ApellidoPaterno;
    private String ApellidoMaterno;
    private String CorreoElectronico;
    private String AreaHospitalaria;
    private String CURP;
    private List<String> Perfiles;
    private String estado;
    
    
    public UsuarioResumenDTO() {
    }

    public UsuarioResumenDTO(int numEmpleado, String nombre, String apellidoPaterno,
                             String apellidoMaterno, String CorreoElectronico, String areaHospitalaria,
                             String curp, List<String> perfiles, String estado) {
        this.NumEmpleado = numEmpleado;
        this.Nombre = nombre;
        this.ApellidoPaterno = apellidoPaterno;
        this.ApellidoMaterno = apellidoMaterno;
        this.CorreoElectronico=CorreoElectronico;
        this.AreaHospitalaria = areaHospitalaria;
        this.CURP = curp;
        this.Perfiles = perfiles;
        this.estado=estado;
    }

    
    public int getNumEmpleado() {
        return NumEmpleado;
    }

    public void setNumEmpleado(int numEmpleado) {
        this.NumEmpleado = numEmpleado;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        this.Nombre = nombre;
    }

    public String getApellidoPaterno() {
        return ApellidoPaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.ApellidoPaterno = apellidoPaterno;
    }

    public String getApellidoMaterno() {
        return ApellidoMaterno;
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.ApellidoMaterno = apellidoMaterno;
    }

    public String getCorreoElectronico() {
        return CorreoElectronico;
    }

    public void setCorreoElectronico(String CorreoElectronico) {
        this.CorreoElectronico = CorreoElectronico;
    }

    public String getAreaHospitalaria() {
        return AreaHospitalaria;
    }

    public void setAreaHospitalaria(String areaHospitalaria) {
        this.AreaHospitalaria = areaHospitalaria;
    }

    public String getCURP() {
        return CURP;
    }

    public void setCURP(String curp) {
        this.CURP = curp;
    }

    public List<String> getPerfiles() {
        return Perfiles;
    }

    public void setPerfiles(List<String> perfiles) {
        this.Perfiles = perfiles;
    }
    
    public String getEstado(){
        return estado;
    }
    
    public void setEstado(String estado){
        this.estado=estado;
    }
}
