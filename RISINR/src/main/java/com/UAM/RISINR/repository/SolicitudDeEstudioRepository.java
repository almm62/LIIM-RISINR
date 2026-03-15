package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.Paciente;
import com.UAM.RISINR.model.SolicitudDeEstudio;
import com.UAM.RISINR.model.SolicitudDeEstudioPK;
import java.util.List;

// Falta comentar
public interface SolicitudDeEstudioRepository extends JpaRepository<SolicitudDeEstudio,SolicitudDeEstudioPK>{
    List<SolicitudDeEstudio> findByEstado(String estado);
    List<SolicitudDeEstudio> findByEstadoAndPacienteIn(String estado, List<Paciente> paciente);
    @Override
    List<SolicitudDeEstudio> findAll();

}
