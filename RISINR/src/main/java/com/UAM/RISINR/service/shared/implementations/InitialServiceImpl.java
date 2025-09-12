package com.UAM.RISINR.service.shared.implementations;

import com.UAM.RISINR.model.dto.shared.AreaDTO;
import com.UAM.RISINR.model.dto.shared.RolDTO;
import com.UAM.RISINR.repository.AreaDeServicioRepository;
import com.UAM.RISINR.repository.RolRepository;
import com.UAM.RISINR.service.shared.InitialService;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class InitialServiceImpl implements InitialService {
    private final AreaDeServicioRepository areaRepo;
    private final RolRepository rolRepo;
    private final ObjectMapper mapper;
    
    public InitialServiceImpl(AreaDeServicioRepository areaRepo, RolRepository rolRepo, ObjectMapper mapper){
        this.areaRepo=areaRepo;
        this.rolRepo=rolRepo;
        this.mapper=mapper;
    }
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
