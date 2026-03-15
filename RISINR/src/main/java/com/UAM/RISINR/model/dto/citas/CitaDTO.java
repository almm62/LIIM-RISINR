package com.UAM.RISINR.model.dto.citas;

public class CitaDTO {
    
    private String idPaciente;
    private String paciente;      
    private String domicilio;
    private String estudio;           
    private Integer idEstudio;
    private String eq_NoSerie;
    private String eq_Ubicacion;
    private Integer idArea;
    private String nombreArea;
    private String turno;
    private String medico;
    private String fechaSolicitud;    
    private String fechaProxima;  
    private Integer noEmpleado;
    private String areaProcedencia;
    private String diagnostico;
    private String observaciones;
    private String ce_usr_curp;
    private Integer noEmpleadoUsuario;
    private Long fechaAsignPk;    
    private String se_curp;
    private String ce_estado;



    

    public CitaDTO() {}
    public CitaDTO(String ce_usr_curp, String eq_NoSerie, String eq_Ubicacion, String ce_estado,
                   Long fechaAsignPk, String fechaProxima, String turno, String idPaciente,
                   String domicilio, Integer noEmpleado,
                   String fechaSolicitud, String nombreArea, String paciente, String estudio,
                   String areaProcedencia, String se_curp,
                   Integer noEmpleadoUsuario, Integer idEstudio,
                   Integer idArea, String diagnostico, String medico, String observaciones) {
        this.ce_usr_curp = ce_usr_curp;
        this.eq_NoSerie = eq_NoSerie;
        this.eq_Ubicacion = eq_Ubicacion;
        this.ce_estado = ce_estado;
        this.fechaAsignPk = fechaAsignPk;
        this.fechaProxima = fechaProxima;
        this.turno = turno;
        this.idPaciente = idPaciente;
        this.domicilio = domicilio;
        this.noEmpleado = noEmpleado;
        this.fechaSolicitud = fechaSolicitud;
        this.nombreArea = nombreArea;
        this.paciente = paciente;
        this.estudio = estudio;
        this.areaProcedencia = areaProcedencia;
        this.se_curp = se_curp;
        this.noEmpleadoUsuario = noEmpleadoUsuario;
        this.idEstudio = idEstudio;
        this.idArea = idArea;
        this.diagnostico = diagnostico;
        this.medico = medico;
        this.observaciones = observaciones;
    }

    public String getCe_usr_curp() { return ce_usr_curp; }
    public void setCe_usr_curp(String ce_usr_curp) { this.ce_usr_curp = ce_usr_curp; }

    public String getEq_NoSerie() { return eq_NoSerie; }
    public void setEq_NoSerie(String eq_NoSerie) { this.eq_NoSerie = eq_NoSerie; }

    public String getEq_Ubicacion() { return eq_Ubicacion; }
    public void setEq_Ubicacion(String eq_Ubicacion) { this.eq_Ubicacion = eq_Ubicacion; }

    public String getCe_Estado() { return ce_estado; }
    public void setCe_Estado(String ce_estado) { this.ce_estado = ce_estado; }

    public Long getFechaAsignPk() { return fechaAsignPk; }
    public void setFechaAsignPk(Long fechaAsignPk) { this.fechaAsignPk = fechaAsignPk; }

    public String getFechaProxima() { return fechaProxima; }
    public void setFechaProxima(String fechaProxima) { this.fechaProxima = fechaProxima; }

    public String getTurno() { return turno; }
    public void setTurno(String turno) { this.turno = turno; }

    public String getIdPaciente() { return idPaciente; }
    public void setIdPaciente(String idPaciente) { this.idPaciente = idPaciente; }

    public String getDomicilio() { return domicilio; }
    public void setDomicilio(String domicilio) { this.domicilio = domicilio; }

    public Integer getNoEmpleado() { return noEmpleado; }
    public void setNoEmpleado(Integer noEmpleado) { this.noEmpleado = noEmpleado; }

    public String getFechaSolicitud() { return fechaSolicitud; }
    public void setFechaSolicitud(String fechaSolicitud) { this.fechaSolicitud = fechaSolicitud; }

    public String getNombreArea() { return nombreArea; }
    public void setNombreArea(String nombreArea) { this.nombreArea = nombreArea; }

    public String getPaciente() { return paciente; }
    public void setPaciente(String paciente) { this.paciente = paciente; }

    public String getEstudio() { return estudio; }
    public void setEstudio(String estudio) { this.estudio = estudio; }

    public String getAreaProcedencia() { return areaProcedencia; }
    public void setAreaProcedencia(String areaProcedencia) { this.areaProcedencia = areaProcedencia; }

    public String getSe_Curp() { return se_curp; }
    public void setSe_Curp(String se_curp) { this.se_curp = se_curp; }

    public Integer getNoEmpleadoUsuario() { return noEmpleadoUsuario; }
    public void setNoEmpleadoUsuario(Integer noEmpleadoUsuario) { this.noEmpleadoUsuario = noEmpleadoUsuario; }

    public Integer getIdEstudio() { return idEstudio; }
    public void setIdEstudio(Integer idEstudio) { this.idEstudio = idEstudio; }

    public Integer getIdArea() { return idArea; }
    public void setIdArea(Integer idArea) { this.idArea = idArea; }

    public String getDiagnostico() { return diagnostico; }
    public void setDiagnostico(String diagnostico) { this.diagnostico = diagnostico; }

    public String getMedico() { return medico; }
    public void setMedico(String medico) { this.medico = medico; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}
