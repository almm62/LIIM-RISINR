package com.UAM.RISINR.service.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Modelo de datos que representa la información de sesión almacenada en el JWT.
 * Contiene los campos mínimos para reconstruir la SesionPK: número de empleado,
 * CURP, hora de inicio (epoch en milisegundos) e identificador de aplicación.
 * @author Pedro Misael Rodríguez Jiménez
 */
public class JwtSessionInfo {

    private final int numEmpleado;     // nme
    private final String curp;         // curp
    private final long horaInicio;     // hst (epoch millis)
    private final int aplicacionId;    // asi

    /**
     * Construye la información de sesión a partir de los campos del subject JWT.
     * @param numEmpleado Número de empleado del usuario (campo "nme")
     * @param curp CURP del usuario (campo "curp")
     * @param horaInicio Marca de tiempo epoch en milisegundos del inicio de sesión (campo "hst")
     * @param aplicacionId Identificador de la aplicación asociada a la sesión (campo "asi")
     */
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

    /** @return Número de empleado del usuario. */
    public int getNumEmpleado() { return numEmpleado; }
    /** @return CURP del usuario. */
    public String getCurp() { return curp; }
    /** @return Hora de inicio de sesión en milisegundos epoch. */
    public long getHoraInicio() { return horaInicio; }
    /** @return Identificador de la aplicación asociada a la sesión. */
    public int getAplicacionId() { return aplicacionId; }
}