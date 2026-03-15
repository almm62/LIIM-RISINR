package com.UAM.RISINR.service.shared.implementations;

import com.UAM.RISINR.model.RegistroEvento;
import com.UAM.RISINR.model.RegistroEventoPK;
import com.UAM.RISINR.repository.RegistroEventoRepository;
import com.UAM.RISINR.service.shared.RegistroEventoService;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Implementación del servicio de registro de eventos. Persiste cada evento en la
 * base de datos con lógica de reintento para resolver colisiones de llave primaria
 * cuando dos eventos ocurren en el mismo milisegundo.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Service
public class RegistroEventoLogger implements RegistroEventoService{

    private final RegistroEventoRepository registroEventoRepo;

    /**
     * Constructor con inyección del repositorio de eventos.
     * @param registroEventoRepo Repositorio de RegistroEvento
     */
    public RegistroEventoLogger(RegistroEventoRepository registroEventoRepo) {
        this.registroEventoRepo = registroEventoRepo;
    }
    /**
     * Registra un evento en la bitácora con lógica de reintento ante colisión de llave primaria.
     * @param eventoId Identificador del tipo de evento
     * @param aplicacionId Identificador de la aplicación que genera el evento
     * @param horaMs Marca de tiempo epoch en milisegundos del evento
     * @param datosJson Datos adicionales del evento en formato JSON
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void log(int eventoId, int aplicacionId, long horaMs, String datosJson) {
        // Reintento simple por posible colisión de PK en el mismo milisegundo
        for (int i = 0; i < 5; i++) {
            try {
                RegistroEventoPK pk = new RegistroEventoPK(eventoId, aplicacionId, horaMs + i);
                RegistroEvento re = new RegistroEvento(pk, datosJson);
                registroEventoRepo.save(re);
                return;
            } catch (DataIntegrityViolationException e) {
            }
        }
    }
}
