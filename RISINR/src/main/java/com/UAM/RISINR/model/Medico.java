package com.UAM.RISINR.model;
import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.CascadeType;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Medico")
public class Medico implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected MedicoPK medicoPK;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "medico")
    private Collection<SolicitudDeEstudio> solicitudDeEstudioCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "medico")
    private Collection<EspecialidadMedica> especialidadMedicaCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "medico")
    private Collection<AgendaDeServicio> agendaDeServicioCollection;

    public Medico() {
    }

    public Medico(MedicoPK medicoPK) {
        this.medicoPK = medicoPK;
    }

    public Medico(int numEmpleado, String curp) {
        this.medicoPK = new MedicoPK(numEmpleado, curp);
    }

    public MedicoPK getMedicoPK() {
        return medicoPK;
    }

    public void setMedicoPK(MedicoPK medicoPK) {
        this.medicoPK = medicoPK;
    }

  //Aquí hay que ver las anotaciones @JSsonManageReferece y @JsonBackReference
    public Collection<SolicitudDeEstudio> getSolicitudDeEstudioCollection() {
        return solicitudDeEstudioCollection;
    }

    public void setSolicitudDeEstudioCollection(Collection<SolicitudDeEstudio> solicitudDeEstudioCollection) {
        this.solicitudDeEstudioCollection = solicitudDeEstudioCollection;
    }

  //Aquí hay que ver las anotaciones @JSsonManageReferece y @JsonBackReference
    public Collection<EspecialidadMedica> getEspecialidadMedicaCollection() {
        return especialidadMedicaCollection;
    }

    public void setEspecialidadMedicaCollection(Collection<EspecialidadMedica> especialidadMedicaCollection) {
        this.especialidadMedicaCollection = especialidadMedicaCollection;
    }

  //Aquí hay que ver las anotaciones @JSsonManageReferece y @JsonBackReference
    public Collection<AgendaDeServicio> getAgendaDeServicioCollection() {
        return agendaDeServicioCollection;
    }

    public void setAgendaDeServicioCollection(Collection<AgendaDeServicio> agendaDeServicioCollection) {
        this.agendaDeServicioCollection = agendaDeServicioCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (medicoPK != null ? medicoPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Medico)) {
            return false;
        }
        Medico other = (Medico) object;
        if ((this.medicoPK == null && other.medicoPK != null) || (this.medicoPK != null && !this.medicoPK.equals(other.medicoPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.RIS.MVC.model.JPA.entities.Medico[ medicoPK=" + medicoPK + " ]";
    }
    
}
