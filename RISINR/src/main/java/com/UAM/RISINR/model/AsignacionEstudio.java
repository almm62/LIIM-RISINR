/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;


import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;
import org.antlr.v4.runtime.misc.NotNull;


@Entity
@Table(name = "AsignacionEstudio")

public class AsignacionEstudio implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @EmbeddedId
    protected AsignacionEstudioPK asignacionEstudioPK;
    
    @Basic(optional = false)
    @NotNull
    @Column(name = "Fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    
    @JoinColumn(name = "EquipoImagenologia_NSerie", referencedColumnName = "NSerie", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private EquipoImagenologia equipoImagenologia;
    
    @JoinColumn(name = "Estudio_idEstudio", referencedColumnName = "idEstudio", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Estudio estudio;

    public AsignacionEstudio() {
    }

    public AsignacionEstudio(AsignacionEstudioPK asignacionEstudioPK) {
        this.asignacionEstudioPK = asignacionEstudioPK;
    }

    public AsignacionEstudio(AsignacionEstudioPK asignacionEstudioPK, Date fecha) {
        this.asignacionEstudioPK = asignacionEstudioPK;
        this.fecha = fecha;
    }

    public AsignacionEstudio(String equipoImagenologiaNSerie, int estudioidEstudio, long fechaPk) {
        this.asignacionEstudioPK = new AsignacionEstudioPK(equipoImagenologiaNSerie, estudioidEstudio, fechaPk);
    }

    public AsignacionEstudioPK getAsignacionEstudioPK() {
        return asignacionEstudioPK;
    }

    public void setAsignacionEstudioPK(AsignacionEstudioPK asignacionEstudioPK) {
        this.asignacionEstudioPK = asignacionEstudioPK;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public EquipoImagenologia getEquipoImagenologia() {
        return equipoImagenologia;
    }

    public void setEquipoImagenologia(EquipoImagenologia equipoImagenologia) {
        this.equipoImagenologia = equipoImagenologia;
    }

    public Estudio getEstudio() {
        return estudio;
    }

    public void setEstudio(Estudio estudio) {
        this.estudio = estudio;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (asignacionEstudioPK != null ? asignacionEstudioPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AsignacionEstudio)) {
            return false;
        }
        AsignacionEstudio other = (AsignacionEstudio) object;
        if ((this.asignacionEstudioPK == null && other.asignacionEstudioPK != null) || (this.asignacionEstudioPK != null && !this.asignacionEstudioPK.equals(other.asignacionEstudioPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.AsignacionEstudio[ asignacionEstudioPK=" + asignacionEstudioPK + " ]";
    }
    
}
