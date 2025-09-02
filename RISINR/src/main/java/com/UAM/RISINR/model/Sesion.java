package com.UAM.RISINR.model;

import java.io.Serializable;
import java.math.BigInteger;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Objects;

@Entity
@Table(name = "Sesion")
public class Sesion implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected SesionPK sesionPK;
    @Size(max = 45)
    @Column(name = "Rol_Nombre")
    private String rolNombre;
    @Column(name = "horaFin")
    private BigInteger horaFin;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "IPDispositivo")
    private String ipDispositivo;
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Usuario_ID")
    private String usuarioID;
    @Size(max = 25)
    @Column(name = "TipoCierre")
    private String tipoCierre;

    public Sesion() {
    }

    public Sesion(SesionPK sesionPK) {
        this.sesionPK = sesionPK;
    }

    public Sesion(SesionPK sesionPK, String ipDispositivo, String usuarioID) {
        this.sesionPK = sesionPK;
        this.ipDispositivo = ipDispositivo;
        this.usuarioID = usuarioID;
    }

    public Sesion(long horaInicio, int usuarioNumEmpleado, String usuarioCURP, int aplicacionID, String ipDispositivo, String usuarioID) {
        this.sesionPK = new SesionPK(horaInicio, usuarioNumEmpleado, usuarioCURP, aplicacionID);
        this.ipDispositivo=ipDispositivo;
        this.usuarioID = usuarioID;
    }
 
    public SesionPK getSesionPK() {
        return sesionPK;
    }

    public void setSesionPK(SesionPK sesionPK) {
        this.sesionPK = sesionPK;
    }

    public String getRolNombre() {
        return rolNombre;
    }

    public void setRolNombre(String rolNombre) {
        this.rolNombre = rolNombre;
    }

    public BigInteger getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(BigInteger horaFin) {
        this.horaFin = horaFin;
    }

    public String getUsuarioID() {
        return usuarioID;
    }

    public void setUsuarioID(String usuarioID) {
        this.usuarioID = usuarioID;
    }

    public String getIPDispositivo() {
        return ipDispositivo;
    }

    public void setIPDispositivo(String ipDispositivo) {
        this.ipDispositivo = ipDispositivo;
    }

    public String getTipoCierre() {
        return tipoCierre;
    }

    public void setTipoCierre(String tipoCierre) {
        this.tipoCierre = tipoCierre;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(sesionPK);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof Sesion)) return false;
        Sesion other = (Sesion) object;
        return Objects.equals(this.sesionPK, other.sesionPK);
    }

    @Override
    public String toString() {
        return "Sesion{sesionPK=" + sesionPK + "}";
    }
    
}
