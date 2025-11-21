package com.UAM.RISINR.model.dto.citas;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;


public class AsignacionEstudioDTO{
	private String eqNoSerie;
	private Integer idestudio;
	private Long fechacontrolpk;
	private Date fechacontrol;

    // Formato de fecha y hora
    private static final DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	private static final ZoneId zona = ZoneId.of("America/Mexico_City");

	public AsignacionEstudioDTO() {}
    
	public AsignacionEstudioDTO(String eqNoSerie, Integer idestudio, Long fechacontrolpk, 
	String fechacontrol) {
		this.eqNoSerie = eqNoSerie;
		this.idestudio = idestudio;
		this.fechacontrolpk = fechacontrolpk;
		this.fechacontrol = parseFecha(fechacontrol);
	}
    
	public AsignacionEstudioDTO(String eqNoSerie, Integer idestudio, Long fechacontrolpk, 
	Date fechacontrol) {
		this.eqNoSerie = eqNoSerie;
		this.idestudio = idestudio;
		this.fechacontrolpk = fechacontrolpk;
		this.fechacontrol = fechacontrol;
	}
    
    private Date parseFecha(String s) {
        if (s == null || s.isBlank()) return null;
        try {
            LocalDateTime ldt = LocalDateTime.parse(s, formato);
            ZonedDateTime zdt = ldt.atZone(zona);
            return Date.from(zdt.toInstant());
        } catch (DateTimeParseException ex) {
			return null;
		}
    }

	// Getters y setters
	public String getEqNoSerie() { return eqNoSerie; }
	public void setEqNoSerie(String eqNoSerie) { this.eqNoSerie = eqNoSerie; }

	public Integer getIdestudio() { return idestudio; }
	public void setIdestudio(Integer idestudio) { this.idestudio = idestudio; }

	public Long getFechacontrolpk() { return fechacontrolpk; }
	public void setFechacontrolpk(Long fechacontrolpk) { this.fechacontrolpk = fechacontrolpk; }

	public Date getFechacontrol() { return fechacontrol; }
	public void setFechacontrol(String fechacontrol) { this.fechacontrol = parseFecha(fechacontrol); }
}