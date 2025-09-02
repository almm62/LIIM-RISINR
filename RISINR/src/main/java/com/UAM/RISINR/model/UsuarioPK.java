package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;


@Embeddable
public class UsuarioPK implements Serializable {

    @NotNull
    @Column(name = "NumEmpleado")
    private int numEmpleado;
    
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "CURP")
    private String curp;

    public UsuarioPK() {
    }

    public UsuarioPK(int numEmpleado, String curp) {
        this.numEmpleado = numEmpleado;
        this.curp = curp;
    }

    public int getNumEmpleado() {
        return numEmpleado;
    }

    public void setNumEmpleado(int numEmpleado) {
        this.numEmpleado = numEmpleado;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) numEmpleado;
        hash += (curp != null ? curp.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof UsuarioPK)) return false;
        UsuarioPK other = (UsuarioPK) object;
        return this.numEmpleado == other.numEmpleado &&
               java.util.Objects.equals(this.curp, other.curp);
    }

    @Override
    public String toString() {
        return "UsuarioPK{numEmpleado=" + numEmpleado + ", curp='" + curp + "'}";
    }
    
}
