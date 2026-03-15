package com.UAM.RISINR.model.dto.citas;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class ReagendaCitaDTO{
	private Integer medNumEmpleado;
	private String medCurp;
	private Integer userNumEmpleado;
	private String userCurp;
	private String NoSerie;
	private String idpaciente;
	private Integer idestudio;
	private Long fechacontrolpk_ant;
	private Long fechacontrolpk_nueva;
	private LocalDateTime fechacontrol_ant;
	private LocalDateTime fechacontrol_nueva;
	private String estado;
	private Boolean cerrado;
	private String observaciones;
	private String motivo;

    // Formato de fecha y hora
    private static final DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	private static final ZoneId zona = ZoneId.of("America/Mexico_City");

	public ReagendaCitaDTO() {}
    
	public ReagendaCitaDTO(Integer medNumEmpleado, String medCurp, Integer userNumEmpleado, String userCurp, String NoSerie, String idpaciente,
						   Integer idestudio, Long fechacontrolpk_ant, Long fechacontrolpk_nueva,
						   String fechacontrol_ant, String fechacontrol_nueva, String estado, 
						   Boolean cerrado, String observaciones, String motivo) {
		this.medNumEmpleado = medNumEmpleado;
		this.medCurp = medCurp;
		this.userNumEmpleado = userNumEmpleado;
		this.userCurp = userCurp;
		this.NoSerie = NoSerie;
		this.idpaciente = idpaciente;
		this.idestudio = idestudio;
		this.fechacontrolpk_ant = fechacontrolpk_ant;
        this.fechacontrolpk_nueva = fechacontrolpk_nueva;
		this.fechacontrol_ant = parseFecha(fechacontrol_ant);
		this.fechacontrol_nueva = parseFecha(fechacontrol_nueva);
		this.estado = estado;
		this.cerrado = cerrado;
		this.observaciones = observaciones;
		this.motivo = motivo;
	}
    
	public ReagendaCitaDTO(Integer medNumEmpleado, String medCurp, Integer userNumEmpleado, String userCurp, String NoSerie, String idpaciente, 
						   Integer idestudio, Long fechacontrolpk_ant, Long fechacontrolpk_nueva,
						   LocalDateTime fechacontrol_ant, LocalDateTime fechacontrol_nueva, String estado, 
						   Boolean cerrado, String observaciones, String motivo) {
		this.medNumEmpleado = medNumEmpleado;
		this.medCurp = medCurp;
		this.userNumEmpleado = userNumEmpleado;
		this.userCurp = userCurp;
		this.idpaciente = idpaciente;
		this.idestudio = idestudio;
		this.NoSerie = NoSerie;
		this.fechacontrolpk_ant = fechacontrolpk_ant;
        this.fechacontrolpk_nueva = fechacontrolpk_nueva;
		this.fechacontrol_ant = fechacontrol_ant;
		this.fechacontrol_nueva = fechacontrol_nueva;
		this.estado = estado;
		this.cerrado = cerrado;
		this.observaciones = observaciones;
		this.motivo = motivo;
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

	// Getters y setters

    public Integer getMedNumEmpleado() {return medNumEmpleado;}
    public void setMedNumEmpleado(Integer medNumEmpleado) {this.medNumEmpleado = medNumEmpleado;}

    public String getMedCurp() {return medCurp;}
    public void setMedCurp(String medCurp) {this.medCurp = medCurp;}

	public Integer getUserNumEmpleado() {return userNumEmpleado;}
	public void setUserNumEmpleado(Integer userNumEmpleado) {this.userNumEmpleado = userNumEmpleado;}

	public String getUserCurp() {return userCurp;}
	public void setUserCurp(String userCurp) {this.userCurp = userCurp;}

    public String getNoSerie() {return NoSerie;}
    public void setNoSerie(String NoSerie) {this.NoSerie = NoSerie;}

	public String getIdpaciente() { return idpaciente; }
	public void setIdpaciente(String idpaciente) { this.idpaciente = idpaciente; }

	public Integer getIdestudio() { return idestudio; }
	public void setIdestudio(Integer idestudio) { this.idestudio = idestudio; }

	public Long getFechacontrolpk_ant() { return fechacontrolpk_ant; }
	public void setFechacontrolpk_ant(Long fechacontrolpk_ant) { this.fechacontrolpk_ant = fechacontrolpk_ant; }
    
	public Long getFechacontrolpk_nueva() { return fechacontrolpk_nueva; }
	public void setFechacontrolpk_nueva(Long fechacontrolpk_nueva) { this.fechacontrolpk_nueva = fechacontrolpk_nueva; }

	public LocalDateTime getFechacontrol_ant() { return fechacontrol_ant; }
	public void setFechacontrol_ant(String fechacontrol_ant) { this.fechacontrol_ant = parseFecha(fechacontrol_ant); }

	public LocalDateTime getFechacontrol_nueva() { return fechacontrol_nueva; }
	public void setFechacontrol_nueva(String fechacontrol_nueva) { this.fechacontrol_nueva = parseFecha(fechacontrol_nueva); }

	public String getEstado() { return estado; }
	public void setEstado(String estado) { this.estado = estado; }

	public Boolean getCerrado() { return cerrado; }
	public void setCerrado(Boolean cerrado) { this.cerrado = cerrado; }

	public String getObservaciones() { return observaciones; }
	public void setObservaciones(String observaciones) { this.observaciones = observaciones; }

    public String getMotivo() {return motivo;}
    public void setMotivo(String motivo) {this.motivo = motivo;}
}
