package com.UAM.RISINR.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.UAM.RISINR.model.AreaDeServicio;
import com.UAM.RISINR.model.Estudio;
import java.util.List;


public interface EstudioRepository extends JpaRepository<Estudio,Integer> {
    List<Estudio> findByAreaDeServicioidArea(AreaDeServicio areaDeServicioidArea);
}
