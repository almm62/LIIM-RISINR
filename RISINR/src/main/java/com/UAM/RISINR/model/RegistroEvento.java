package com.UAM.RISINR.model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "RegistroEvento")
public class RegistroEvento {

    @EmbeddedId
    private RegistroEventoPK id;

    @Basic(optional = false)
    @Column(name = "Datos", columnDefinition = "longtext", nullable = false)
    private String datos; // Aquí se recibe el JSON como String

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Evento_idEvento", referencedColumnName = "idEvento", insertable = false, updatable = false)
    private Evento evento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Aplicacion_idAplicacion", referencedColumnName = "idAplicacion", insertable = false, updatable = false)
    private Aplicacion aplicacion;

    public RegistroEvento() {}

    public RegistroEvento(RegistroEventoPK id, String datos) {
        this.id = id;
        this.datos = datos;
    }

    public RegistroEventoPK getId() { return id; }
    public void setId(RegistroEventoPK id) { this.id = id; }

    public String getDatos() { return datos; }
    public void setDatos(String datos) { this.datos = datos; }

    public Evento getEvento() { return evento; }
    public void setEvento(Evento evento) { this.evento = evento; }

    public Aplicacion getAplicacion() { return aplicacion; }
    public void setAplicacion(Aplicacion aplicacion) { this.aplicacion = aplicacion; }
}
