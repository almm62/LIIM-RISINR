package com.UAM.RISINR.model.dto.citas;

public class SolicitudDeEstudioDTO {
    
    private String idPaciente;
    private String paciente; 
    private Integer noEmpleado;
    private String curp;
    private String medico;
    private Long fechaSolicitudPK;    
    private String fechaSolicitud;    
    private String fechaProxima;  
    private String areaProcedencia;
    private String diagnostico;
    private String observaciones;

    public SolicitudDeEstudioDTO() {}

    public SolicitudDeEstudioDTO(String idPaciente, String paciente, Integer noEmpleado,
                                String curp, String medico, Long fechaSolicitudPK,
                                String fechaSolicitud, String fechaProxima,
                                String areaProcedencia, String diagnostico,
                                String observaciones) {
        this.idPaciente = idPaciente;
        this.paciente = paciente;
        this.noEmpleado = noEmpleado;
        this.curp = curp;
        this.medico = medico;
        this.fechaSolicitudPK = fechaSolicitudPK;
        this.fechaSolicitud = fechaSolicitud;
        this.fechaProxima = fechaProxima;
        this.areaProcedencia = areaProcedencia;
        this.diagnostico = diagnostico;
        this.observaciones = observaciones;
    }

    public String getIdPaciente() {
        return idPaciente;
    }
    public void setIdPaciente(String idPaciente) {
        this.idPaciente = idPaciente;
    }

    public String getPaciente() {
        return paciente;
    }
    public void setPaciente(String paciente) {
        this.paciente = paciente;
    }

    public Integer getNoEmpleado() {
        return noEmpleado;
    }
    public void setNoEmpleado(Integer noEmpleado) {
        this.noEmpleado = noEmpleado;
    }

    public String getCurp() {
        return curp;
    }
    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getMedico() {
        return medico;
    }
    public void setMedico(String medico) {
        this.medico = medico;
    }

    public Long getFechaSolicitudPK() {
        return fechaSolicitudPK;
    }
    public void setFechaSolicitudPK(Long fechaSolicitudPK) {
        this.fechaSolicitudPK = fechaSolicitudPK;
    }

    public String getFechaSolicitud() {
        return fechaSolicitud;
    }
    public void setFechaSolicitud(String fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getFechaProxima() {
        return fechaProxima;
    }
    public void setFechaProxima(String fechaProxima) {
        this.fechaProxima = fechaProxima;
    }

    public String getAreaProcedencia() {
        return areaProcedencia;
    }
    public void setAreaProcedencia(String areaProcedencia) {
        this.areaProcedencia = areaProcedencia;
    }

    public String getDiagnostico() {
        return diagnostico;
    }
    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    public String getObservaciones() {
        return observaciones;
    }
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
}
