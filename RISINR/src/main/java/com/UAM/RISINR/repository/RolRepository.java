package com.UAM.RISINR.repository;

import com.UAM.RISINR.model.Rol;
import com.UAM.RISINR.repository.projection.RolView;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RolRepository extends JpaRepository<Rol, Integer> {

    List<RolView> findByIdRolIn(Collection<Integer> ids);
}
