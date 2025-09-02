package com.UAM.RISINR.model;

import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;


/**
 *
 * @author DDT1
 */
@Entity
@Table(name = "Estudio")
public class Estudio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idEstudio")
    private Integer idEstudio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 64)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 65)
    @Column(name = "Descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "estudioidEstudio")
    private Collection<ProtocoloEstudio> protocoloEstudioCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "estudio")
    private Collection<AsignacionEstudio> asignacionEstudioCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "estudio")
    private Collection<ControlEstudios> controlEstudiosCollection;
    @JoinColumn(name = "AreaDeServicio_idArea", referencedColumnName = "idArea")
    @ManyToOne(optional = false)
    private AreaDeServicio areaDeServicioidArea;

    public Estudio() {
    }

    public Estudio(Integer idEstudio) {
        this.idEstudio = idEstudio;
    }

    public Estudio(Integer idEstudio, String nombre, String descripcion) {
        this.idEstudio = idEstudio;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Integer getIdEstudio() {
        return idEstudio;
    }

    public void setIdEstudio(Integer idEstudio) {
        this.idEstudio = idEstudio;
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


    public Collection<ProtocoloEstudio> getProtocoloEstudioCollection() {
        return protocoloEstudioCollection;
    }

    public void setProtocoloEstudioCollection(Collection<ProtocoloEstudio> protocoloEstudioCollection) {
        this.protocoloEstudioCollection = protocoloEstudioCollection;
    }


    public Collection<AsignacionEstudio> getAsignacionEstudioCollection() {
        return asignacionEstudioCollection;
    }

    public void setAsignacionEstudioCollection(Collection<AsignacionEstudio> asignacionEstudioCollection) {
        this.asignacionEstudioCollection = asignacionEstudioCollection;
    }

    public Collection<ControlEstudios> getControlEstudiosCollection() {
        return controlEstudiosCollection;
    }

    public void setControlEstudiosCollection(Collection<ControlEstudios> controlEstudiosCollection) {
        this.controlEstudiosCollection = controlEstudiosCollection;
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
        hash += (idEstudio != null ? idEstudio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Estudio)) {
            return false;
        }
        Estudio other = (Estudio) object;
        if ((this.idEstudio == null && other.idEstudio != null) || (this.idEstudio != null && !this.idEstudio.equals(other.idEstudio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.Estudio[ idEstudio=" + idEstudio + " ]";
    }
    
}
