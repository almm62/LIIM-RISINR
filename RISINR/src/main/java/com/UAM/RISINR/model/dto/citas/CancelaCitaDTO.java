package com.UAM.RISINR.model.dto.citas;

public class CancelaCitaDTO {
	private Integer NumEmpleado;
	private String curp;
	private Integer idestudio;
	private String idpaciente;
	private Long fechacontrolpk;
    private String motivo;
    private String NoSerie;
    private Integer medNumEmpleado;
    private String medCurp;

    public CancelaCitaDTO() {
    }

    public CancelaCitaDTO(Integer NumEmpleado, String curp, Integer idestudio, 
                          String idpaciente, Long fechacontrolpk, String motivo,
                          String NoSerie, Integer medNumEmpleado, String medCurp) {
        this.NumEmpleado = NumEmpleado;
        this.curp = curp;
        this.idestudio = idestudio;
        this.idpaciente = idpaciente;
        this.fechacontrolpk = fechacontrolpk;
        this.motivo = motivo;
        this.NoSerie = NoSerie;
        this.medNumEmpleado = medNumEmpleado;
        this.medCurp = medCurp;
    }

    public Integer getNumEmpleado() {
        return NumEmpleado;
    }

    public void setNumEmpleado(Integer NumEmpleado) {
        this.NumEmpleado = NumEmpleado;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public Integer getIdestudio() {
        return idestudio;
    }

    public void setIdestudio(Integer idestudio) {
        this.idestudio = idestudio;
    }

    public String getIdpaciente() {
        return idpaciente;
    }

    public void setIdpaciente(String idpaciente) {
        this.idpaciente = idpaciente;
    }

    public Long getFechacontrolpk() {
        return fechacontrolpk;
    }

    public void setFechacontrolpk(Long fechacontrolpk) {
        this.fechacontrolpk = fechacontrolpk;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getNoSerie() {
        return NoSerie;
    }
    public void setNoSerie(String NoSerie) {
        this.NoSerie = NoSerie;
    }

    public Integer getMedNumEmpleado() {
        return medNumEmpleado;
    }
    public void setMedNumEmpleado(Integer medNumEmpleado) {
        this.medNumEmpleado = medNumEmpleado;
    }

    public String getMedCurp() {
        return medCurp;
    }
    public void setMedCurp(String medCurp) {
        this.medCurp = medCurp;
    }
}
