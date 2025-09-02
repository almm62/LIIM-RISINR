package com.UAM.RISINR.model;


import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Aplicacion")
public class Aplicacion implements Serializable {

    @Id
    @Column(name = "idAplicacion", nullable = false)
    private Integer idAplicacion;

    @Basic(optional = false)
    @Column(name = "Nombre", length = 50, nullable = false)
    private String nombre;

    @Column(name = "Descripcion", length = 100)
    private String descripcion;

    // Relación inversa con RegistroEvento
    @OneToMany(mappedBy = "aplicacion", fetch = FetchType.LAZY)
    private List<RegistroEvento> registrosEvento;

    public Aplicacion() {}

    public Aplicacion(Integer idAplicacion, String nombre, String descripcion) {
        this.idAplicacion = idAplicacion;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // Getters & Setters
    public Integer getIdAplicacion() { return idAplicacion; }
    public void setIdAplicacion(Integer idAplicacion) { this.idAplicacion = idAplicacion; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public List<RegistroEvento> getRegistrosEvento() { return registrosEvento; }
    public void setRegistrosEvento(List<RegistroEvento> registrosEvento) { this.registrosEvento = registrosEvento; }

    @Override
    public String toString() {
        return "Aplicacion{" +
                "idAplicacion=" + idAplicacion +
                ", nombre='" + nombre + '\'' +
                ", descripcion='" + descripcion + '\'' +
                '}';
    }
}
