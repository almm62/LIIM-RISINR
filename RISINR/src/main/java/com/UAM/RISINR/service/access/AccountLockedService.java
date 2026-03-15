package com.UAM.RISINR.service.access;

/**
 * Interfaz del servicio de bloqueo de cuentas de usuario. Define el contrato
 * para bloquear el acceso de un usuario al sistema.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface AccountLockedService {
    /**
     * Bloquea la cuenta del usuario indicado cambiando su estado a "Bloqueado".
     * @param usuarioId Identificador del usuario a bloquear
     */
    public void block(String usuarioId);
}
