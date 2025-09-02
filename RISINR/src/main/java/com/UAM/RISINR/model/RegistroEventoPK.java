package com.UAM.RISINR.model;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class RegistroEventoPK implements Serializable {

    @Column(name = "Evento_idEvento", nullable = false)
    private Integer eventoId;

    @Column(name = "Aplicacion_idAplicacion", nullable = false)
    private Integer aplicacionId;

    @Column(name = "horaEvento", nullable = false)
    private Long horaEvento;

    public RegistroEventoPK() {}

    public RegistroEventoPK(Integer eventoId, Integer aplicacionId, Long horaEvento) {
        this.eventoId = eventoId;
        this.aplicacionId = aplicacionId;
        this.horaEvento = horaEvento;
    }

    public Integer getEventoId() { return eventoId; }
    public void setEventoId(Integer eventoId) { this.eventoId = eventoId; }

    public Integer getAplicacionId() { return aplicacionId; }
    public void setAplicacionId(Integer aplicacionId) { this.aplicacionId = aplicacionId; }

    public Long getHoraEvento() { return horaEvento; }
    public void setHoraEvento(Long horaEvento) { this.horaEvento = horaEvento; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof RegistroEventoPK)) return false;
        RegistroEventoPK that = (RegistroEventoPK) o;
        return Objects.equals(eventoId, that.eventoId) &&
               Objects.equals(aplicacionId, that.aplicacionId) &&
               Objects.equals(horaEvento, that.horaEvento);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eventoId, aplicacionId, horaEvento);
    }
}