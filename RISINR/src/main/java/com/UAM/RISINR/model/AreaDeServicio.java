package com.UAM.RISINR.model;

import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;


/**
 *
 * @author DDT1
 */
@Entity
@Table(name = "AreaDeServicio")

public class AreaDeServicio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idArea")
    private Integer idArea;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "Nombre")
    private String nombre;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 120)
    @Column(name = "Descripcion")
    private String descripcion;
    
    
    
    
    //@JsonBackReference
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "areaDeServicioidArea")
    private Collection<EquipoImagenologia> equipoImagenologiaCollection;
    /*
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "areaDeServicioidArea")
    private Collection<Estudio> estudioCollection;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "areaidArea")
    private Collection<Usuario> usuarioCollection;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "areaDeServicioidArea")
    private Collection<Equipo> equipoCollection;
    
    */

    public AreaDeServicio() {
    }

    public AreaDeServicio(Integer idArea) {
        this.idArea = idArea;
    }

    public AreaDeServicio(Integer idArea, String nombre, String descripcion) {
        this.idArea = idArea;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Integer getIdArea() {
        return idArea;
    }

    public void setIdArea(Integer idArea) {
        this.idArea = idArea;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /*
    public Collection<Usuario> getUsuarioCollection() {
        return usuarioCollection;
    }

    public void setUsuarioCollection(Collection<Usuario> usuarioCollection) {
        this.usuarioCollection = usuarioCollection;
    }

    
    public Collection<Equipo> getEquipoCollection() {
        return equipoCollection;
    }

    public void setEquipoCollection(Collection<Equipo> equipoCollection) {
        this.equipoCollection = equipoCollection;
    }

    
    

    
    public Collection<Estudio> getEstudioCollection() {
        return estudioCollection;
    }

    public void setEstudioCollection(Collection<Estudio> estudioCollection) {
        this.estudioCollection = estudioCollection;
    }
    */
    public Collection<EquipoImagenologia> getEquipoImagenologiaCollection() {
        return equipoImagenologiaCollection;
    }

    public void setEquipoImagenologiaCollection(Collection<EquipoImagenologia> equipoImagenologiaCollection) {
        this.equipoImagenologiaCollection = equipoImagenologiaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idArea != null ? idArea.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AreaDeServicio)) {
            return false;
        }
        AreaDeServicio other = (AreaDeServicio) object;
        if ((this.idArea == null && other.idArea != null) || (this.idArea != null && !this.idArea.equals(other.idArea))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.AreaDeServicio[ idArea=" + idArea + " ]";
    }
    
}
