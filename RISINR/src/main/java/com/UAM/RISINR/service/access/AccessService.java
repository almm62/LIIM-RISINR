package com.UAM.RISINR.service.access;

import com.UAM.RISINR.model.dto.access.LoginRequestDTO;
import com.UAM.RISINR.model.dto.access.LoginResponseDTO;
import com.UAM.RISINR.model.dto.access.SelectRolRequestDTO;

/**
 * Interfaz para gestionar operaciones de acceso y autenticación en el sistema.
 * Proporciona métodos para el inicio de sesión, selección de roles y cierre de sesión
 * de usuarios, manejando la seguridad y el control de acceso de la aplicación.
 * Implementa la lógica de negocio relacionada con la autenticación y autorización.
 * 
 * @author Pedro Misael Rodríguez Jiménez
 */
public interface AccessService {

    LoginResponseDTO login(LoginRequestDTO request, String ipDispositivo);

    LoginResponseDTO seleccionarRol(SelectRolRequestDTO request, String ipDispositivo);
   
    void logout(String subjectJson, String tipoCierre);
}