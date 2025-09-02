package com.UAM.RISINR.repository.projection;

public interface RolView {
    Integer    getIdRol();       // PK → no nulo
    String getNombre();
    String getDescripcion();
}
