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
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "ProtocoloEstudio")
public class ProtocoloEstudio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idProtocolo")
    private Integer idProtocolo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 65)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 65)
    @Column(name = "Descripcion")
    private String descripcion;
    @JoinColumn(name = "Estudio_idEstudio", referencedColumnName = "idEstudio")
    @ManyToOne(optional = false)
    private Estudio estudioidEstudio;

    public ProtocoloEstudio() {
    }

    public ProtocoloEstudio(Integer idProtocolo) {
        this.idProtocolo = idProtocolo;
    }

    public ProtocoloEstudio(Integer idProtocolo, String nombre, String descripcion) {
        this.idProtocolo = idProtocolo;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Integer getIdProtocolo() {
        return idProtocolo;
    }

    public void setIdProtocolo(Integer idProtocolo) {
        this.idProtocolo = idProtocolo;
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

    public Estudio getEstudioidEstudio() {
        return estudioidEstudio;
    }

    public void setEstudioidEstudio(Estudio estudioidEstudio) {
        this.estudioidEstudio = estudioidEstudio;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idProtocolo != null ? idProtocolo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProtocoloEstudio)) {
            return false;
        }
        ProtocoloEstudio other = (ProtocoloEstudio) object;
        if ((this.idProtocolo == null && other.idProtocolo != null) || (this.idProtocolo != null && !this.idProtocolo.equals(other.idProtocolo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.ProtocoloEstudio[ idProtocolo=" + idProtocolo + " ]";
    }
    
}
