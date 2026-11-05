package com.example.hospital.service;

import com.example.hospital.entity.Patient;
import com.example.hospital.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service Layer: Contains business operations for Patient Registration.
 */
@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    // 1. Get all registered patients
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    // 2. Find a patient by Patient ID
    public Patient getPatientById(Long id) {
        return patientRepository.findById(id).orElse(null);
    }

    // 3. Save a new patient or update an existing patient
    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }

    // 4. Delete patient by Patient ID
    public void deletePatient(Long id) {
        patientRepository.deleteById(id);
    }
}
