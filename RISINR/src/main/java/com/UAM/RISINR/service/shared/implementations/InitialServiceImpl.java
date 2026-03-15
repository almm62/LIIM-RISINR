package com.UAM.RISINR.service.shared.implementations;

import com.UAM.RISINR.model.dto.shared.AreaDTO;
import com.UAM.RISINR.model.dto.shared.RolDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.RolRepository;
import com.UAM.RISINR.service.shared.InitialService;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import org.springframework.stereotype.Service;

/**
 * Implementación del servicio de datos iniciales. Consulta las áreas de servicio
 * y los roles en la base de datos y los serializa como listas de cadenas JSON
 * mediante ObjectMapper.
 * @author Pedro Misael Rodríguez Jiménez
 */
@Service
public class InitialServiceImpl implements InitialService {
    private final AreaDeServicioRepository areaRepo;
    private final RolRepository rolRepo;
    private final ObjectMapper mapper;
    
    /**
     * Constructor con inyección de repositorios y mapper para la serialización de datos iniciales.
     * @param areaRepo Repositorio de áreas de servicio
     * @param rolRepo Repositorio de roles
     * @param mapper Mapper para serialización a JSON
     */
    public InitialServiceImpl(AreaDeServicioRepository areaRepo, RolRepository rolRepo, ObjectMapper mapper){
        this.areaRepo=areaRepo;
        this.rolRepo=rolRepo;
        this.mapper=mapper;
    }
    /**
     * Retorna la lista de todas las áreas de servicio serializadas como cadenas JSON.
     * @return Lista de cadenas JSON, una por cada AreaDeServicio registrada
     */
    @Override
    public List<String> getAreas() {
        return areaRepo.findAll()
                .stream()
                .map(a -> {
                    try {
                        AreaDTO dto = new AreaDTO(
                                a.getIdArea(),
                                a.getNombre(),
                                a.getDescripcion()
                        );
                        return mapper.writeValueAsString(dto);
                    } catch (Exception e) {
                        throw new RuntimeException("Error serializando AreaDTO", e);
                    }
                })
                .toList();
    }

    /**
     * Retorna la lista de todos los roles disponibles serializados como cadenas JSON.
     * @return Lista de cadenas JSON, una por cada Rol registrado
     */
    @Override
    public List<String> getRoles() {
        return rolRepo.findAll()
                .stream()
                .map(r -> {
                    try {
                        RolDTO dto = new RolDTO(
                                r.getIdRol(),
                                r.getNombre(),
                                r.getDescripcion()
                        );
                        return mapper.writeValueAsString(dto);
                    } catch (Exception e) {
                        throw new RuntimeException("Error serializando RolDTO", e);
                    }
                })
                .toList();
    }
    
}
