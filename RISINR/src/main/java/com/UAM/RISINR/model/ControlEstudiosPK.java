/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.criteria.CriteriaBuilder.In;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 *
 * @author DDT1
 */
@Embeddable
public class ControlEstudiosPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "Usuario_NumEmpleado")
    private int usuarioNumEmpleado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Usuario_CURP")
    private String usuarioCURP;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "Paciente_IDPaciente")
    private String pacienteIDPaciente;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Estudio_idEstudio")
    private int estudioidEstudio;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FechaControlPk")
    private long fechaControlPk;

    
    @Basic(optional = false)
    @NotNull
    @Column(name = "EquipoImagenologia_NSerie")
    private String equipoImagenologiaNSerie;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Medico_NumEmpleado")
    private Integer medicoNumEmpleado;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Medico_CURP")
    private String medicoCURP;

    public ControlEstudiosPK() {
    }

    public ControlEstudiosPK(int usuarioNumEmpleado, String usuarioCURP, String pacienteIDPaciente, int estudioidEstudio, long fechaControlPk, String equipoImagenologiaNSerie, Integer medicoNumEmpleado, String medicoCURP) {
        this.usuarioNumEmpleado = usuarioNumEmpleado;
        this.usuarioCURP = usuarioCURP;
        this.pacienteIDPaciente = pacienteIDPaciente;
        this.estudioidEstudio = estudioidEstudio;
        this.fechaControlPk = fechaControlPk;
        this.equipoImagenologiaNSerie = equipoImagenologiaNSerie;
        this.medicoNumEmpleado = medicoNumEmpleado;
        this.medicoCURP = medicoCURP;
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

    public String getPacienteIDPaciente() {
        return pacienteIDPaciente;
    }

    public void setPacienteIDPaciente(String pacienteIDPaciente) {
        this.pacienteIDPaciente = pacienteIDPaciente;
    }

    public int getEstudioidEstudio() {
        return estudioidEstudio;
    }

    public void setEstudioidEstudio(int estudioidEstudio) {
        this.estudioidEstudio = estudioidEstudio;
    }

    public long getFechaControlPk() {
        return fechaControlPk;
    }

    public void setFechaControlPk(long fechaControlPk) {
        this.fechaControlPk = fechaControlPk;
    }

    public String getEquipoImagenologiaNSerie() {
        return equipoImagenologiaNSerie;
    }
    public void setEquipoImagenologiaNSerie(String equipoImagenologiaNSerie) {
        this.equipoImagenologiaNSerie = equipoImagenologiaNSerie;
    }

    public Integer getMedicoNumEmpleado() {
        return medicoNumEmpleado;
    }
    public void setMedicoNumEmpleado(Integer medicoNumEmpleado) {
        this.medicoNumEmpleado = medicoNumEmpleado;
    }

    public String getMedicoCURP() {
        return medicoCURP;
    }
    public void setMedicoCURP(String medicoCURP) {
        this.medicoCURP = medicoCURP;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) usuarioNumEmpleado;
        hash += (usuarioCURP != null ? usuarioCURP.hashCode() : 0);
        hash += (pacienteIDPaciente != null ? pacienteIDPaciente.hashCode() : 0);
        hash += (int) estudioidEstudio;
        hash += (int) fechaControlPk;
        hash += (equipoImagenologiaNSerie != null ? equipoImagenologiaNSerie.hashCode() : 0);
        hash += (medicoNumEmpleado != null ? medicoNumEmpleado.hashCode() : 0);
        hash += (medicoCURP != null ? medicoCURP.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ControlEstudiosPK)) {
            return false;
        }
        ControlEstudiosPK other = (ControlEstudiosPK) object;
        if (this.usuarioNumEmpleado != other.usuarioNumEmpleado) {
            return false;
        }
        if ((this.usuarioCURP == null && other.usuarioCURP != null) || (this.usuarioCURP != null && !this.usuarioCURP.equals(other.usuarioCURP))) {
            return false;
        }
        if ((this.pacienteIDPaciente == null && other.pacienteIDPaciente != null) || (this.pacienteIDPaciente != null && !this.pacienteIDPaciente.equals(other.pacienteIDPaciente))) {
            return false;
        }
        if (this.estudioidEstudio != other.estudioidEstudio) {
            return false;
        }
        if (this.fechaControlPk != other.fechaControlPk) {
            return false;
        }
        if ((this.equipoImagenologiaNSerie == null && other.equipoImagenologiaNSerie != null) || (this.equipoImagenologiaNSerie != null && !this.equipoImagenologiaNSerie.equals(other.equipoImagenologiaNSerie))) {
            return false;
        }
        if ((this.medicoNumEmpleado == null && other.medicoNumEmpleado != null) || (this.medicoNumEmpleado != null && !this.medicoNumEmpleado.equals(other.medicoNumEmpleado))) {
            return false;
        }
        if ((this.medicoCURP == null && other.medicoCURP != null) || (this.medicoCURP != null && !this.medicoCURP.equals(other.medicoCURP))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.ControlEstudiosPK[ usuarioNumEmpleado=" + usuarioNumEmpleado + ", usuarioCURP=" + usuarioCURP + ", pacienteIDPaciente=" + pacienteIDPaciente + ", estudioidEstudio=" + estudioidEstudio + ", fechaControlPk=" + fechaControlPk + ", equipoImagenologiaNSerie=" + equipoImagenologiaNSerie + ", medicoNumEmpleado=" + medicoNumEmpleado + ", medicoCURP=" + medicoCURP + " ]";
    }
    
}
