package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Sesion;
import com.UAM.RISINR.model.SesionPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SesionRepository extends JpaRepository<Sesion, SesionPK> { }
