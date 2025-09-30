package com.UAM.RISINR.model;

import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.Objects;


@Entity
@Table(name = "Rol")
public class Rol implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @NotNull
    @Column(name = "idRol")
    private Integer idRol;
    
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "Nombre", nullable = false, length = 30)
    private String nombre;
    
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "Descripcion", nullable = false, length = 100)
    private String descripcion;
    
    @OneToMany(mappedBy = "rol", fetch = FetchType.LAZY)
    private Collection<Perfil> perfilCollection;

    public Rol() {
    }

    public Rol(Integer idRol) {
        this.idRol = idRol;
    }

    public Rol(Integer idRol, String nombre, String descripcion) {
        this.idRol = idRol;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Integer getIdRol() {
        return idRol;
    }

    public void setIdRol(Integer idRol) {
        this.idRol = idRol;
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

    public Collection<Perfil> getPerfilCollection() {
        return perfilCollection;
    }

    public void setPerfilCollection(Collection<Perfil> perfilCollection) {
        this.perfilCollection = perfilCollection;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idRol);
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof Rol)) return false;
        Rol other = (Rol) object;
        return Objects.equals(this.idRol, other.idRol);
    }

    @Override
    public String toString() {
        return "Rol{ idRol=" + idRol + ", nombre='" + nombre + "'}";
    }  
}