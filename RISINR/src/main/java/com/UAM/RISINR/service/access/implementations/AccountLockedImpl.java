package com.UAM.RISINR.service.access.implementations;

import com.UAM.RISINR.repository.DatosAccesoRepository;
import com.UAM.RISINR.service.access.AccountLockedService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Service
public class AccountLockedImpl implements AccountLockedService{

    private final DatosAccesoRepository accesoRepo;

    public AccountLockedImpl(DatosAccesoRepository accesoRepo) {
        this.accesoRepo = accesoRepo;
    }
    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void block(String usuarioId) {
        var usuario = accesoRepo.findByIdUsuarioID(usuarioId).get();
        usuario.setEstado("Bloqueado");
        accesoRepo.save(usuario);
    }
}
