package com.UAM.RISINR.service.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class JwtSessionInfo {

    private final int numEmpleado;     // nme
    private final String curp;         // curp
    private final long horaInicio;     // hst (epoch millis)
    private final int aplicacionId;    // asi

    @JsonCreator
    public JwtSessionInfo(@JsonProperty("nme") int numEmpleado,
                          @JsonProperty("curp") String curp,
                          @JsonProperty("hst") long horaInicio,
                          @JsonProperty("asi") int aplicacionId) {
        this.numEmpleado = numEmpleado;
        this.curp = curp;
        this.horaInicio = horaInicio;
        this.aplicacionId = aplicacionId;
    }

    public int getNumEmpleado() { return numEmpleado; }
    public String getCurp() { return curp; }
    public long getHoraInicio() { return horaInicio; }
    public int getAplicacionId() { return aplicacionId; }
}