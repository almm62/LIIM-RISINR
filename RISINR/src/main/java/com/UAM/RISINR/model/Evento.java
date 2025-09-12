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
@Table(name = "Evento")
public class Evento implements Serializable {

    @Id
    @Column(name = "idEvento", nullable = false)
    private Integer idEvento;

 
    @Basic(optional = false)
    @Column(name = "Descripcion", length = 45, nullable = false)
    private String descripcion;

    // Relación inversa con RegistroEvento
    @OneToMany(mappedBy = "evento", fetch = FetchType.LAZY)
    private List<RegistroEvento> registrosEvento;

    public Evento() {}

    public Evento(Integer idEvento, String descripcion) {
        this.idEvento = idEvento;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public Integer getIdEvento() { return idEvento; }
    public void setIdEvento(Integer idEvento) { this.idEvento = idEvento; }


    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public List<RegistroEvento> getRegistrosEvento() { return registrosEvento; }
    public void setRegistrosEvento(List<RegistroEvento> registrosEvento) { this.registrosEvento = registrosEvento; }
}