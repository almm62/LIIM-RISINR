package com.UAM.RISINR.service.shared;

/**
 * Interfaz del servicio de registro de eventos. Define el contrato para registrar
 * en bitácora los eventos del sistema con su identificador, aplicación, marca de
 * tiempo y datos asociados en formato JSON.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface RegistroEventoService {
    /**
     * Registra un evento en la bitácora del sistema.
     * @param eventoId Identificador del tipo de evento
     * @param aplicacionId Identificador de la aplicación que genera el evento
     * @param horaMs Marca de tiempo epoch en milisegundos del evento
     * @param datosJson Datos adicionales del evento en formato JSON
     */
    void log(int eventoId, int aplicacionId, long horaMs, String datosJson);
}
