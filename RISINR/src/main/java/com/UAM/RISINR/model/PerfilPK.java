package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Objects;

@Embeddable
public class PerfilPK implements Serializable {

    @NotNull
    @Column(name = "Usuario_NumEmpleado")
    private int usuarioNumEmpleado;
    
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Usuario_CURP")
    private String usuarioCURP;
    
    @NotNull
    @Column(name = "Rol_idRol")
    private int rolidRol;

    public PerfilPK() {
    }

    public PerfilPK(int usuarioNumEmpleado, String usuarioCURP, int rolidRol) {
        this.usuarioNumEmpleado = usuarioNumEmpleado;
        this.usuarioCURP = usuarioCURP;
        this.rolidRol = rolidRol;
    }

    public int getUsuarioNumEmpleado() {
        return usuarioNumEmpleado;
    }

    public void setUsuarioNumEmpleado(int usuarioNumEmpleado) {
        this.usuarioNumEmpleado = usuarioNumEmpleado;
    }

    public String getUsuarioCURP() {
        return usuarioCURP;
    }

    public void setUsuarioCURP(String usuarioCURP) {
        this.usuarioCURP = usuarioCURP;
    }

    public int getRolidRol() {
        return rolidRol;
    }

    public void setRolidRol(int rolidRol) {
        this.rolidRol = rolidRol;
    }

    @Override
    public int hashCode() {
        return Objects.hash(usuarioNumEmpleado, usuarioCURP, rolidRol);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof PerfilPK)) return false;
        PerfilPK other = (PerfilPK) object;
        return this.usuarioNumEmpleado == other.usuarioNumEmpleado
            && this.rolidRol == other.rolidRol
            && Objects.equals(this.usuarioCURP, other.usuarioCURP);
    }

    @Override
    public String toString() {
        return "PerfilPK{usuarioNumEmpleado=" + usuarioNumEmpleado + ", usuarioCURP=" + usuarioCURP + ", rolidRol=" + rolidRol + " ]";
    }
    
}
