package com.UAM.RISINR.model;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "DatosAcceso")
public class DatosAcceso{

    @EmbeddedId
    private DatosAccesoPK id;

    @Column(name = "Contraseña", length = 20, nullable = false)
    private String contrasena;

    @Column(name = "Estado", length = 45, nullable = false)
    private String estado;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumns({
        @JoinColumn(name = "Usuario_NumEmpleado", referencedColumnName = "NumEmpleado", insertable = false, updatable = false),
        @JoinColumn(name = "Usuario_CURP", referencedColumnName = "CURP", insertable = false, updatable = false)
    })
    private Usuario usuario;

    public DatosAcceso() {}

    public DatosAcceso(DatosAccesoPK id, String contrasena, String estado, Usuario usuario) {
        this.id = id;
        this.contrasena = contrasena;
        this.estado = estado;
        this.usuario = usuario;
    }

    public DatosAccesoPK getId() {
        return id;
    }

    public void setId(DatosAccesoPK id) {
        this.id = id;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
}
