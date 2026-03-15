/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "ControlEstudios")
public class ControlEstudios implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ControlEstudiosPK controlEstudiosPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FechaControl")
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime fechaControl;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Estado")
    private String estado;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Cerrado")
    private boolean cerrado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 250)
    @Column(name = "Observaciones")
    private String observaciones;
    @JoinColumn(name = "Estudio_idEstudio", referencedColumnName = "idEstudio", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Estudio estudio;
    @JoinColumn(name = "Paciente_IDPaciente", referencedColumnName = "idPaciente", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Paciente paciente;
    @JoinColumns({
        @JoinColumn(name = "Usuario_NumEmpleado", referencedColumnName = "NumEmpleado", insertable = false, updatable = false),
        @JoinColumn(name = "Usuario_CURP", referencedColumnName = "CURP", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private Usuario usuario;

    @JoinColumn(name = "EquipoImagenologia_NSerie", referencedColumnName = "NSerie", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private EquipoImagenologia equipoImagenologia;
    @JoinColumns({
        @JoinColumn(name = "Medico_NumEmpleado", referencedColumnName = "NumEmpleado", insertable = false, updatable = false),
        @JoinColumn(name = "Medico_CURP", referencedColumnName = "CURP", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private Medico medico;

    public ControlEstudios() {
    }

    public ControlEstudios(ControlEstudiosPK controlEstudiosPK) {
        this.controlEstudiosPK = controlEstudiosPK;
    }

    public ControlEstudios(ControlEstudiosPK controlEstudiosPK, LocalDateTime fechaControl, String estado, boolean cerrado, String observaciones) {
        this.controlEstudiosPK = controlEstudiosPK;
        this.fechaControl = fechaControl;
        this.estado = estado;
        this.cerrado = cerrado;
        this.observaciones = observaciones;
    }

    public ControlEstudios(int usuarioNumEmpleado, String usuarioCURP, String pacienteIDPaciente, int estudioidEstudio, long fechaControlPk, String equipoImagenologiaNSerie, Integer medicoNumEmpleado, String medicoCURP) {
        this.controlEstudiosPK = new ControlEstudiosPK(usuarioNumEmpleado, usuarioCURP, pacienteIDPaciente, estudioidEstudio, fechaControlPk, equipoImagenologiaNSerie, medicoNumEmpleado, medicoCURP);
    }

    public ControlEstudiosPK getControlEstudiosPK() {
        return controlEstudiosPK;
    }

    public void setControlEstudiosPK(ControlEstudiosPK controlEstudiosPK) {
        this.controlEstudiosPK = controlEstudiosPK;
    }

    public LocalDateTime getFechaControl() {
        return fechaControl;
    }

    public void setFechaControl(LocalDateTime fechaControl) {
        this.fechaControl = fechaControl;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean getCerrado() {
        return cerrado;
    }

    public void setCerrado(boolean cerrado) {
        this.cerrado = cerrado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Estudio getEstudio() {
        return estudio;
    }

    public void setEstudio(Estudio estudio) {
        this.estudio = estudio;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public EquipoImagenologia getEquipoImagenologia() {
        return equipoImagenologia;
    }
    public void setEquipoImagenologia(EquipoImagenologia equipoImagenologia) {
        this.equipoImagenologia = equipoImagenologia;
    }

    public Medico getMedico() {
        return medico;
    }
    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (controlEstudiosPK != null ? controlEstudiosPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ControlEstudios)) {
            return false;
        }
        ControlEstudios other = (ControlEstudios) object;
        if ((this.controlEstudiosPK == null && other.controlEstudiosPK != null) || (this.controlEstudiosPK != null && !this.controlEstudiosPK.equals(other.controlEstudiosPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.ControlEstudios[ controlEstudiosPK=" + controlEstudiosPK + " ]";
    }
    
}
