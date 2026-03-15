package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.ControlEstudios;
import com.UAM.RISINR.model.ControlEstudiosPK;
import com.UAM.RISINR.model.Estudio;
import com.UAM.RISINR.model.Medico;
import com.UAM.RISINR.model.Paciente;

import java.util.List;

// No se ha comentado
public interface ControlEstudiosRepository extends JpaRepository<ControlEstudios,ControlEstudiosPK>{
    List<ControlEstudios> findByEstudio(Estudio estudio);
    List<ControlEstudios> findByEstudioIn(List<Estudio> estudio);
    List<ControlEstudios> findByEstudioInAndEstadoInAndCerradoIsFalse(List<Estudio> estudio, List<String> estado);
    List<ControlEstudios> findByEstudioInAndEstadoInAndPacienteInAndCerradoIsFalse(List<Estudio> estudio, List<String> estado, List<Paciente> pacientes);
    List<ControlEstudios> findByControlEstudiosPK_FechaControlPkAndMedicoAndPacienteAndEstadoNot(long fechacontrolpk, Medico medico, Paciente paciente, String estado);
}
