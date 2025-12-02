package com.UAM.RISINR.service.citas;

import java.util.List;

import com.UAM.RISINR.model.dto.citas.AgendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.AsignacionEstudioDTO;
import com.UAM.RISINR.model.dto.citas.CancelaCitaDTO;
import com.UAM.RISINR.model.dto.citas.CitaDTO;
import com.UAM.RISINR.model.dto.citas.EstudioDTO;
import com.UAM.RISINR.model.dto.citas.ReagendaCitaDTO;
import com.UAM.RISINR.model.dto.citas.SalaDTO;

public interface CitasService {
    List<EstudioDTO> getStudies (String token);
    List<SalaDTO> getSalas (String token);
    List<CitaDTO> getAll (String token);
    CitaDTO CreateStudyControl (String token, AgendaCitaDTO dto);
    AsignacionEstudioDTO CreateStudyAssignment(String token, AsignacionEstudioDTO dto);
    CitaDTO UpdateStudyControl(String token, ReagendaCitaDTO dto);
    void CancelStudyControl (String token, CancelaCitaDTO dto);
    void Consultorio(String token);
}
