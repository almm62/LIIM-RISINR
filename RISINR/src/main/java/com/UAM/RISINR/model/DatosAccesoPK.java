package com.UAM.RISINR.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class DatosAccesoPK implements Serializable {

    @Column(name = "UsuarioID", length = 45, nullable = false)
    private String usuarioID;

    @Column(name = "Usuario_NumEmpleado", nullable = false)
    private Integer usuarioNumEmpleado;

    @Column(name = "Usuario_CURP", length = 45, nullable = false)
    private String usuarioCURP;

    public DatosAccesoPK() {}

    public DatosAccesoPK(String usuarioID, Integer usuarioNumEmpleado, String usuarioCURP) {
        this.usuarioID = usuarioID;
        this.usuarioNumEmpleado = usuarioNumEmpleado;
        this.usuarioCURP = usuarioCURP;
    }

    public String getUsuarioID() {
        return usuarioID;
    }

    public void setUsuarioID(String usuarioID) {
        this.usuarioID = usuarioID;
    }

    public Integer getUsuarioNumEmpleado() {
        return usuarioNumEmpleado;
    }

    public void setUsuarioNumEmpleado(Integer usuarioNumEmpleado) {
        this.usuarioNumEmpleado = usuarioNumEmpleado;
    }

    public String getUsuarioCURP() {
        return usuarioCURP;
    }

    public void setUsuarioCURP(String usuarioCURP) {
        this.usuarioCURP = usuarioCURP;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof DatosAccesoPK)) return false;
        DatosAccesoPK that = (DatosAccesoPK) o;
        return Objects.equals(usuarioID, that.usuarioID) &&
               Objects.equals(usuarioNumEmpleado, that.usuarioNumEmpleado) &&
               Objects.equals(usuarioCURP, that.usuarioCURP);
    }

    @Override
    public int hashCode() {
        return Objects.hash(usuarioID, usuarioNumEmpleado, usuarioCURP);
    }
}