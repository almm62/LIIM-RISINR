package com.UAM.RISINR.model.dto.citas;

public class EstudioDTO {
    private Integer idestudio;
    private String estudio;

    public EstudioDTO() {
    }

    public EstudioDTO(Integer idestudio, String estudio) {
        this.idestudio = idestudio;
        this.estudio = estudio;
    }

    public Integer getIdestudio() {
        return idestudio;
    }

    public void setIdestudio(Integer idestudio) {
        this.idestudio = idestudio;
    }

    public String getEstudio() {
        return estudio;
    }

    public void setEstudio(String estudio) {
        this.estudio = estudio;
    }
}
