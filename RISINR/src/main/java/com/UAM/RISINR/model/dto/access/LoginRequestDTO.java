package com.UAM.RISINR.model.dto.access;

import com.fasterxml.jackson.annotation.JsonProperty;

public class LoginRequestDTO {
    
    @JsonProperty("usuarioId")
    private String usuarioId;

    @JsonProperty("passwd")
    private String passwd;

    public LoginRequestDTO() {
    }

    public LoginRequestDTO(String usuarioId, String passwd) {
        this.usuarioId = usuarioId;
        this.passwd = passwd;
    }


    public String getUsuario() {
        return usuarioId;
    }

    public void setUsuario(String usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getContrasena() {
        return passwd;
    }

    public void setContrasena(String contrasena) {
        this.passwd = contrasena;
    }
}
