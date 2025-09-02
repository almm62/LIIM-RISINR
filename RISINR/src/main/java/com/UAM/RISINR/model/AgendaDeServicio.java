/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;

import java.io.Serializable;
import java.util.Date;
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
@Table(name = "AgendaDeServicio")
public class AgendaDeServicio implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AgendaDeServicioPK agendaDeServicioPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FechaControl")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaControl;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "TipoMantenimiento")
    private String tipoMantenimiento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "EstadoDeManto")
    private String estadoDeManto;
    @Size(max = 100)
    @Column(name = "Descrpcion")
    private String descrpcion;
    @JoinColumn(name = "EquipoImagenologia_NSerie", referencedColumnName = "NSerie", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private EquipoImagenologia equipoImagenologia;
    @JoinColumns({
        @JoinColumn(name = "Medico_NumEmpleado", referencedColumnName = "NumEmpleado", insertable = false, updatable = false),
        @JoinColumn(name = "Medico_CURP", referencedColumnName = "CURP", insertable = false, updatable = false)})
    @ManyToOne(optional = false)
    private Medico medico;

    public AgendaDeServicio() {
    }

    public AgendaDeServicio(AgendaDeServicioPK agendaDeServicioPK) {
        this.agendaDeServicioPK = agendaDeServicioPK;
    }

    public AgendaDeServicio(AgendaDeServicioPK agendaDeServicioPK, Date fechaControl, String tipoMantenimiento, String estadoDeManto) {
        this.agendaDeServicioPK = agendaDeServicioPK;
        this.fechaControl = fechaControl;
        this.tipoMantenimiento = tipoMantenimiento;
        this.estadoDeManto = estadoDeManto;
    }

    public AgendaDeServicio(String equipoImagenologiaNSerie, int medicoNumEmpleado, String medicoCURP, long fechaControlPk) {
        this.agendaDeServicioPK = new AgendaDeServicioPK(equipoImagenologiaNSerie, medicoNumEmpleado, medicoCURP, fechaControlPk);
    }

    public AgendaDeServicioPK getAgendaDeServicioPK() {
        return agendaDeServicioPK;
    }

    public void setAgendaDeServicioPK(AgendaDeServicioPK agendaDeServicioPK) {
        this.agendaDeServicioPK = agendaDeServicioPK;
    }

    public Date getFechaControl() {
        return fechaControl;
    }

    public void setFechaControl(Date fechaControl) {
        this.fechaControl = fechaControl;
    }

    public String getTipoMantenimiento() {
        return tipoMantenimiento;
    }

    public void setTipoMantenimiento(String tipoMantenimiento) {
        this.tipoMantenimiento = tipoMantenimiento;
    }

    public String getEstadoDeManto() {
        return estadoDeManto;
    }

    public void setEstadoDeManto(String estadoDeManto) {
        this.estadoDeManto = estadoDeManto;
    }

    public String getDescrpcion() {
        return descrpcion;
    }

    public void setDescrpcion(String descrpcion) {
        this.descrpcion = descrpcion;
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
        hash += (agendaDeServicioPK != null ? agendaDeServicioPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AgendaDeServicio)) {
            return false;
        }
        AgendaDeServicio other = (AgendaDeServicio) object;
        if ((this.agendaDeServicioPK == null && other.agendaDeServicioPK != null) || (this.agendaDeServicioPK != null && !this.agendaDeServicioPK.equals(other.agendaDeServicioPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.AgendaDeServicio[ agendaDeServicioPK=" + agendaDeServicioPK + " ]";
    }
    
}
