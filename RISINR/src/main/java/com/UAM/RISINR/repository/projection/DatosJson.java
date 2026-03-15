package com.UAM.RISINR.repository.projection;

/**
 * Proyección para consultas que retornan datos en formato JSON.
 * Utilizada en consultas personalizadas del repositorio RegistroEvento.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface DatosJson {
    /** @return Cadena con el contenido JSON del campo datos. */
    String getDatos();
}
