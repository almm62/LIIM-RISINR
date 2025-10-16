package com.UAM.RISINR.model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

//import org.antlr.v4.runtime.misc.NotNull;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "EquipoImagenologia")

public class EquipoImagenologia implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "NSerie")
    private String nSerie;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "Nombre")
    private String nombre;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "Marca")
    private String marca;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "Modelo")
    private String modelo;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "Modalidad")
    private String modalidad;
    
    @Column(name = "FechaInstalacion")
    @Temporal(TemporalType.DATE)
    private Date fechaInstalacion;
    
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Estado")
    private String estado;
    
  /*
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "equipoImagenologia")
    private Collection<AsignacionEstudio> asignacionEstudioCollection;
      
     @OneToMany(cascade = CascadeType.ALL, mappedBy = "equipoImagenologia")
    private Collection<AgendaDeServicio> agendaDeServicioCollection;
    */
    
    //@JsonManagedReference
    @JoinColumn(name = "AreaDeServicio_idArea", referencedColumnName = "idArea")
    @ManyToOne(optional = false)
    private AreaDeServicio areaDeServicioidArea;
    

   

    public EquipoImagenologia() {
    }

    public EquipoImagenologia(String nSerie) {
        this.nSerie = nSerie;
    }

    public EquipoImagenologia(String nSerie, String nombre, String marca, String modelo, String modalidad, String estado) {
        this.nSerie = nSerie;
        this.nombre = nombre;
        this.marca = marca;
        this.modelo = modelo;
        this.modalidad = modalidad;
        this.estado = estado;
    }

    public EquipoImagenologia(String nSerie, String nombre, String marca, String modelo, String modalidad, String estado, AreaDeServicio areaDeServicioidArea) {
        this.nSerie = nSerie;
        this.nombre = nombre;
        this.marca = marca;
        this.modelo = modelo;
        this.modalidad = modalidad;
        this.estado = estado;
        this.areaDeServicioidArea = areaDeServicioidArea;
    }
    


    public String getnSerie() {
        return nSerie;
    }

    public void setnSerie(String nSerie) {
        this.nSerie = nSerie;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getModalidad() {
        return modalidad;
    }

    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }

    public Date getFechaInstalacion() {
        return fechaInstalacion;
    }

    public void setFechaInstalacion(Date fechaInstalacion) {
        this.fechaInstalacion = fechaInstalacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
     public AreaDeServicio getAreaDeServicioidArea() {
        return areaDeServicioidArea;
    }

    public void setAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea) {
        this.areaDeServicioidArea = areaDeServicioidArea;
    }

/*
    public Collection<AsignacionEstudio> getAsignacionEstudioCollection() {
        return asignacionEstudioCollection;
    }

    public void setAsignacionEstudioCollection(Collection<AsignacionEstudio> asignacionEstudioCollection) {
        this.asignacionEstudioCollection = asignacionEstudioCollection;
    }

   

    public Collection<AgendaDeServicio> getAgendaDeServicioCollection() {
        return agendaDeServicioCollection;
    }

    public void setAgendaDeServicioCollection(Collection<AgendaDeServicio> agendaDeServicioCollection) {
        this.agendaDeServicioCollection = agendaDeServicioCollection;
    }
*/
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (nSerie != null ? nSerie.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EquipoImagenologia)) {
            return false;
        }
        EquipoImagenologia other = (EquipoImagenologia) object;
        if ((this.nSerie == null && other.nSerie != null) || (this.nSerie != null && !this.nSerie.equals(other.nSerie))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.EquipoImagenologia[ nSerie=" + nSerie + " ]";
    }
    
}
