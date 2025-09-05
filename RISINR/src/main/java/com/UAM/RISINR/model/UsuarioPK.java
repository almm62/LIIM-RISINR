package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Objects;


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
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UsuarioPK)) return false;
        UsuarioPK that = (UsuarioPK) o;
        return Objects.equals(numEmpleado, that.numEmpleado)
            && Objects.equals(curp, that.curp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(numEmpleado, curp);
    }

    @Override
    public String toString() {
        return "UsuarioPK{numEmpleado=" + numEmpleado + ", curp='" + curp + "'}";
    }
    
}
