package com.UAM.RISINR.service.shared;

public interface RegistroEventoService {
    
    void log(int eventoId, int aplicacionId, long horaMs, String datosJson);
}
