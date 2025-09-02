/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.UAM.RISINR.model;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 *
 * @author DDT1
 */
@Entity
@Table(name = "Equipo")
public class Equipo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "NSerie")
    private String nSerie;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "Ubicacion")
    private String ubicacion;
    
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "equipo")
    private ConfiguracionRIS configuracionRIS;
    
    @JoinColumn(name = "AreaDeServicio_idArea", referencedColumnName = "idArea")
    @ManyToOne(optional = false)
    private AreaDeServicio areaDeServicioidArea;

    public Equipo() {
    }

    public Equipo(String nSerie) {
        this.nSerie = nSerie;
    }

    public Equipo(String nSerie, String ubicacion) {
        this.nSerie = nSerie;
        this.ubicacion = ubicacion;
    }

    public String getNSerie() {
        return nSerie;
    }

    public void setNSerie(String nSerie) {
        this.nSerie = nSerie;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public ConfiguracionRIS getConfiguracionRIS() {
        return configuracionRIS;
    }

    public void setConfiguracionRIS(ConfiguracionRIS configuracionRIS) {
        this.configuracionRIS = configuracionRIS;
    }

    public AreaDeServicio getAreaDeServicioidArea() {
        return areaDeServicioidArea;
    }

    public void setAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea) {
        this.areaDeServicioidArea = areaDeServicioidArea;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nSerie != null ? nSerie.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipo)) {
            return false;
        }
        Equipo other = (Equipo) object;
        if ((this.nSerie == null && other.nSerie != null) || (this.nSerie != null && !this.nSerie.equals(other.nSerie))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.Equipo[ nSerie=" + nSerie + " ]";
    }
    
}
