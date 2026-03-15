package com.UAM.RISINR.service.access;

import com.UAM.RISINR.model.dto.access.LoginRequestDTO;
import com.UAM.RISINR.model.dto.access.LoginResponseDTO;
import com.UAM.RISINR.model.dto.access.SelectRolRequestDTO;

/**
 * Interfaz para gestionar operaciones de acceso y autenticación en el sistema.
 * Proporciona métodos para el inicio de sesión, selección de roles y cierre de sesión
 * de usuarios, manejando la seguridad y el control de acceso de la aplicación.
 * Implementa la lógica de negocio relacionada con la autenticación y autorización.
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface AccessService {

    /**
     * Autentica al usuario y retorna su información de sesión y roles disponibles.
     * @param request Credenciales de acceso (usuario y contraseña)
     * @param ipDispositivo Dirección IP del cliente
     * @return LoginResponseDTO con información del usuario, área, roles y token si aplica
     */
    LoginResponseDTO login(LoginRequestDTO request, String ipDispositivo);

    /**
     * Procesa la selección de rol cuando el usuario tiene múltiples roles disponibles.
     * @param request Identificador de usuario y rol seleccionado
     * @param ipDispositivo Dirección IP del cliente
     * @return LoginResponseDTO con la sesión creada para el rol elegido
     */
    LoginResponseDTO seleccionarRol(SelectRolRequestDTO request, String ipDispositivo);

    /**
     * Cierra la sesión activa del usuario y registra la hora y tipo de cierre.
     * @param subjectJson JSON con los datos de sesión extraídos del token JWT
     * @param tipoCierre Tipo de cierre (ej. "NORMAL", "TIMEOUT")
     */
    void logout(String subjectJson, String tipoCierre);
}