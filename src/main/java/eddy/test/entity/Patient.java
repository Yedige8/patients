package eddy.test.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patient_id")
    private Long patientId;

    @OneToMany(mappedBy = "patient")
    private List<History> histories;

    @Column(name = "patient_iin")
    private String patientIin;

    @Column(name = "patient_full_name")
    private String patientFullName;

    @Column(name = "patient_address")
    private String patientAddress;

    @Column(name = "patient_phone")
    private String patientPhone;

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public List<History> getHistories() {
        return histories;
    }

    public void setHistories(List<History> histories) {
        this.histories = histories;
    }

    public String getPatientIin() {
        return patientIin;
    }

    public void setPatientIin(String patientIin) {
        this.patientIin = patientIin;
    }

    public String getPatientFullName() {
        return patientFullName;
    }

    public void setPatientFullName(String patientFullName) {
        this.patientFullName = patientFullName;
    }

    public String getPatientAddress() {
        return patientAddress;
    }

    public void setPatientAddress(String patientAddress) {
        this.patientAddress = patientAddress;
    }

    public String getPatientPhone() {
        return patientPhone;
    }

    public void setPatientPhone(String patientPhone) {
        this.patientPhone = patientPhone;
    }
}
