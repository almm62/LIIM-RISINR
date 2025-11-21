package com.UAM.RISINR.model.dto.citas;

public class CitaDTO {

    private String ce_usr_curp;//private String ce_usr_curp;
    private String eq_NoSerie;
    private String eq_Ubicacion;
    private String ce_estado;

    private Long fechaAsignPk;        // epoch millis
    private String fechaProxima;      // "YYYY-MM-DD HH:mm:ss.S"
    private String turno;

    private String idPaciente;
    private String horaCita;          // "HH:mm:ss.S"
    private String domicilio;

    private Integer noEmpleado;
    private String fechaSolicitud;    // "YYYY-MM-DD HH:mm:ss.S"
    private String nombreArea;

    private String paciente;          // nombre del paciente compuesto
    private Integer estudio;           // nombre del estudio
    private String areaProcedencia;

    private String se_curp;
    private Integer noEmpleadoUsuario;

    private String fechaCita;         // "YYYY-MM-DD"
    private Integer idEstudio;
    private Integer idArea;

    private String diagnostico;
    private String medico;
    private String observaciones;

    public CitaDTO() {}
    public CitaDTO(String ce_usr_curp, String eq_NoSerie, String eq_Ubicacion, String ce_estado,
                   Long fechaAsignPk, String fechaProxima, String turno, String idPaciente,
                   String horaCita, String domicilio, Integer noEmpleado,
                   String fechaSolicitud, String nombreArea, String paciente, Integer estudio,
                   String areaProcedencia, String se_curp,
                   Integer noEmpleadoUsuario, String fechaCita, Integer idEstudio,
                   Integer idArea, String diagnostico, String medico, String observaciones) {
        this.ce_usr_curp = ce_usr_curp;
        this.eq_NoSerie = eq_NoSerie;
        this.eq_Ubicacion = eq_Ubicacion;
        this.ce_estado = ce_estado;
        this.fechaAsignPk = fechaAsignPk;
        this.fechaProxima = fechaProxima;
        this.turno = turno;
        this.idPaciente = idPaciente;
        this.horaCita = horaCita;
        this.domicilio = domicilio;
        this.noEmpleado = noEmpleado;
        this.fechaSolicitud = fechaSolicitud;
        this.nombreArea = nombreArea;
        this.paciente = paciente;
        this.estudio = estudio;
        this.areaProcedencia = areaProcedencia;
        this.se_curp = se_curp;
        this.noEmpleadoUsuario = noEmpleadoUsuario;
        this.fechaCita = fechaCita;
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

    public String getHoraCita() { return horaCita; }
    public void setHoraCita(String horaCita) { this.horaCita = horaCita; }

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

    public Integer getEstudio() { return estudio; }
    public void setEstudio(Integer estudio) { this.estudio = estudio; }

    public String getAreaProcedencia() { return areaProcedencia; }
    public void setAreaProcedencia(String areaProcedencia) { this.areaProcedencia = areaProcedencia; }

    public String getSe_Curp() { return se_curp; }
    public void setSe_Curp(String se_curp) { this.se_curp = se_curp; }

    public Integer getNoEmpleadoUsuario() { return noEmpleadoUsuario; }
    public void setNoEmpleadoUsuario(Integer noEmpleadoUsuario) { this.noEmpleadoUsuario = noEmpleadoUsuario; }

    public String getFechaCita() { return fechaCita; }
    public void setFechaCita(String fechaCita) { this.fechaCita = fechaCita; }

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
