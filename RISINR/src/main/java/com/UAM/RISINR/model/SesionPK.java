package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Objects;

@Embeddable
public class SesionPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "horaInicio")
    private long horaInicio;
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Usuario_CURP")
    private String usuarioCURP;
    @NotNull
    @Column(name = "Usuario_NumEmpleado")
    private int usuarioNumEmpleado;
    @NotNull
    @Column(name = "Aplicacion_idAplicacion")
    private int aplicacionID;
    

    public SesionPK() {
    }


    public SesionPK(long horaInicio, int usuarioNumEmpleado, String usuarioCURP, int aplicacionID) {
        this.horaInicio = horaInicio;
        this.usuarioNumEmpleado = usuarioNumEmpleado;
        this.usuarioCURP = usuarioCURP;
        this.aplicacionID = aplicacionID;
    }

    public long getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(long horaInicio) {
        this.horaInicio = horaInicio;
    }

    public int getusuarioNumEmpleado() {
        return usuarioNumEmpleado;
    }
    
    public void setusuarioNumEmpleado(int usuarioNumEmpleado) {
        this.usuarioNumEmpleado = usuarioNumEmpleado;
    }
    
    public int getaplicacionID() {
        return aplicacionID;
    }
    
    public void setaplicacionID(int aplicacionID) {
        this.aplicacionID = aplicacionID;
        
    }
    
    public String getusuarioCURP() {
        return usuarioCURP;
    }
    
    public void setusuarioCURP(String usuarioCURP) {
        this.usuarioCURP = usuarioCURP;
    }
    
    
    
    @Override
    public int hashCode() {
        return Objects.hash(horaInicio, usuarioCURP, usuarioNumEmpleado, aplicacionID);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof SesionPK)) return false;
        SesionPK other = (SesionPK) object;
        return horaInicio == other.horaInicio
            && usuarioNumEmpleado == other.usuarioNumEmpleado
            && aplicacionID == other.aplicacionID
            && Objects.equals(usuarioCURP, other.usuarioCURP);
    }

    @Override
    public String toString() {
        return "SesionPK{horaInicio=" + horaInicio +
              ", usuarioCURP='" + usuarioCURP + '\'' +
               ", usuarioNumEmpleado=" + usuarioNumEmpleado +
               ", aplicacionID=" + aplicacionID + '}';
    }
    
}
