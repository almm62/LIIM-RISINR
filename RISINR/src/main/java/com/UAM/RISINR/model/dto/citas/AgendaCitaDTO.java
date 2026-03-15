package com.UAM.RISINR.model.dto.citas;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class AgendaCitaDTO{
	private String idpaciente;
	private Integer idestudio;
	private Long fechacontrolpk;
	private LocalDateTime fechacontrol;
	private String estado;
	private Boolean cerrado;
	private String observaciones;
	private String eqNoSerie;
	private Integer medNumEmpleado;
	private String medCurp;

    // Formato de fecha y hora
    private static final DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	private static final ZoneId zona = ZoneId.of("America/Mexico_City");

	public AgendaCitaDTO() {}
    
	public AgendaCitaDTO(String idpaciente, Integer idestudio, Long fechacontrolpk, 
	String fechacontrol, String estado, Boolean cerrado, String observaciones, 
	String eqNoSerie, Integer medNumEmpleado, String medCurp) {
		this.idpaciente = idpaciente;
		this.idestudio = idestudio;
		this.fechacontrolpk = fechacontrolpk;
		this.fechacontrol = parseFecha(fechacontrol);
		this.estado = estado;
		this.cerrado = cerrado;
		this.observaciones = observaciones;
		this.eqNoSerie = eqNoSerie;
		this.medNumEmpleado = medNumEmpleado;
		this.medCurp = medCurp;
	}
    
	public AgendaCitaDTO(String idpaciente, Integer idestudio, Long fechacontrolpk, 
	LocalDateTime fechacontrol, String estado, Boolean cerrado, String observaciones, 
	String eqNoSerie, Integer medNumEmpleado, String medCurp) {
		this.idpaciente = idpaciente;
		this.idestudio = idestudio;
		this.fechacontrolpk = fechacontrolpk;
		this.fechacontrol = fechacontrol;
		this.estado = estado;
		this.cerrado = cerrado;
		this.observaciones = observaciones;
		this.eqNoSerie = eqNoSerie;
		this.medNumEmpleado = medNumEmpleado;
		this.medCurp = medCurp;
	}
    
    private LocalDateTime parseFecha(String s) {
        if (s == null || s.isBlank()) return null;
        try {
            LocalDateTime ldt = LocalDateTime.parse(s, formato);
            ZonedDateTime zdt = ldt.atZone(zona);
            return LocalDateTime.from(zdt.toInstant());
        } catch (DateTimeParseException ex) {
			return null;
		}
    }

	public String getIdpaciente() { return idpaciente; }
	public void setIdpaciente(String idpaciente) { this.idpaciente = idpaciente; }

	public Integer getIdestudio() { return idestudio; }
	public void setIdestudio(Integer idestudio) { this.idestudio = idestudio; }

	public Long getFechacontrolpk() { return fechacontrolpk; }
	public void setFechacontrolpk(Long fechacontrolpk) { this.fechacontrolpk = fechacontrolpk; }

	public LocalDateTime getFechacontrol() { return fechacontrol; }
	public void setFechacontrol(String fechacontrol) { this.fechacontrol = parseFecha(fechacontrol); }

	public String getEstado() { return estado; }
	public void setEstado(String estado) { this.estado = estado; }

	public Boolean getCerrado() { return cerrado; }
	public void setCerrado(Boolean cerrado) { this.cerrado = cerrado; }

	public String getObservaciones() { return observaciones; }
	public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

	public String getEqNoSerie() { return eqNoSerie; }
	public void setEqNoSerie(String eqNoSerie) { this.eqNoSerie = eqNoSerie; }

	public Integer getMedNumEmpleado() { return medNumEmpleado; }
	public void setMedNumEmpleado(Integer medNumEmpleado) { this.medNumEmpleado = medNumEmpleado; }

	public String getMedCurp() { return medCurp; }
	public void setMedCurp(String medCurp) { this.medCurp = medCurp; }
}