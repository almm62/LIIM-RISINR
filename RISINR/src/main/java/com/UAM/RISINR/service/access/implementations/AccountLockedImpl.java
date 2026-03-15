package com.UAM.RISINR.service.access.implementations;

import com.UAM.RISINR.repository.DatosAccesoRepository;
import com.UAM.RISINR.service.access.AccountLockedService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Implementación del servicio de bloqueo de cuentas. Cambia el estado del usuario
 * a "Bloqueado" en la base de datos dentro de una transacción independiente.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Service
public class AccountLockedImpl implements AccountLockedService{

    private final DatosAccesoRepository accesoRepo;

    /**
     * Constructor con inyección del repositorio de credenciales de acceso.
     * @param accesoRepo Repositorio de DatosAcceso
     */
    public AccountLockedImpl(DatosAccesoRepository accesoRepo) {
        this.accesoRepo = accesoRepo;
    }
    /**
     * Bloquea la cuenta del usuario cambiando su estado a "Bloqueado" en una transacción independiente.
     * @param usuarioId Identificador del usuario a bloquear
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void block(String usuarioId) {
        var usuario = accesoRepo.findByIdUsuarioID(usuarioId).get();
        usuario.setEstado("Bloqueado");
        accesoRepo.save(usuario);
    }
}
