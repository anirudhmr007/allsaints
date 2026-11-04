package com.example.hospital.service;

import com.example.hospital.entity.Patient;
import com.example.hospital.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PatientService {

    private final PatientRepository patientRepository;

    @Autowired
    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Optional<Patient> getPatientById(Long id) {
        return patientRepository.findById(id);
    }

    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }

    public Patient updatePatient(Long id, Patient updatedPatient) {
        return patientRepository.findById(id).map(existing -> {
            existing.setName(updatedPatient.getName());
            existing.setAge(updatedPatient.getAge());
            existing.setGender(updatedPatient.getGender());
            existing.setContactNumber(updatedPatient.getContactNumber());
            existing.setEmail(updatedPatient.getEmail());
            existing.setAddress(updatedPatient.getAddress());
            existing.setBloodGroup(updatedPatient.getBloodGroup());
            return patientRepository.save(existing);
        }).orElseThrow(() -> new IllegalArgumentException("Patient not found with ID: " + id));
    }

    public boolean deletePatientById(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public List<Patient> searchPatientsByName(String name) {
        return patientRepository.findByNameContainingIgnoreCase(name);
    }
}

