/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "Domicilio")
public class Domicilio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "Paciente_IDPaciente")
    private String pacienteIDPaciente;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Calle")
    private String calle;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "Numero")
    private String numero;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Colonia")
    private String colonia;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "AlcaldiaMunicipio")
    private String alcaldiaMunicipio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "Estado")
    private String estado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "CP")
    private String cp;
    @Column(name = "TiempoDeTraslado")
    private Integer tiempoDeTraslado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "Telefono")
    private String telefono;
    @JoinColumn(name = "Paciente_IDPaciente", referencedColumnName = "idPaciente", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Paciente paciente;

    public Domicilio() {
    }

    public Domicilio(String pacienteIDPaciente) {
        this.pacienteIDPaciente = pacienteIDPaciente;
    }

    public Domicilio(String pacienteIDPaciente, String calle, String numero, String colonia, String alcaldiaMunicipio, String estado, String cp, String telefono) {
        this.pacienteIDPaciente = pacienteIDPaciente;
        this.calle = calle;
        this.numero = numero;
        this.colonia = colonia;
        this.alcaldiaMunicipio = alcaldiaMunicipio;
        this.estado = estado;
        this.cp = cp;
        this.telefono = telefono;
    }

    public String getPacienteIDPaciente() {
        return pacienteIDPaciente;
    }

    public void setPacienteIDPaciente(String pacienteIDPaciente) {
        this.pacienteIDPaciente = pacienteIDPaciente;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getColonia() {
        return colonia;
    }

    public void setColonia(String colonia) {
        this.colonia = colonia;
    }

    public String getAlcaldiaMunicipio() {
        return alcaldiaMunicipio;
    }

    public void setAlcaldiaMunicipio(String alcaldiaMunicipio) {
        this.alcaldiaMunicipio = alcaldiaMunicipio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public Integer getTiempoDeTraslado() {
        return tiempoDeTraslado;
    }

    public void setTiempoDeTraslado(Integer tiempoDeTraslado) {
        this.tiempoDeTraslado = tiempoDeTraslado;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (pacienteIDPaciente != null ? pacienteIDPaciente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Domicilio)) {
            return false;
        }
        Domicilio other = (Domicilio) object;
        if ((this.pacienteIDPaciente == null && other.pacienteIDPaciente != null) || (this.pacienteIDPaciente != null && !this.pacienteIDPaciente.equals(other.pacienteIDPaciente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.Domicilio[ pacienteIDPaciente=" + pacienteIDPaciente + " ]";
    }
    
}
