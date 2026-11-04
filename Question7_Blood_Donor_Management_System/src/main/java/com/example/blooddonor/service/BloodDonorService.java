package com.example.blooddonor.service;

import com.example.blooddonor.entity.BloodDonor;
import com.example.blooddonor.repository.BloodDonorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BloodDonorService {

    private final BloodDonorRepository donorRepository;

    @Autowired
    public BloodDonorService(BloodDonorRepository donorRepository) {
        this.donorRepository = donorRepository;
    }

    public List<BloodDonor> getAllDonors() {
        return donorRepository.findAll();
    }

    public Optional<BloodDonor> getDonorById(Long id) {
        return donorRepository.findById(id);
    }

    public List<BloodDonor> searchDonorsByBloodGroup(String bloodGroup) {
        return donorRepository.findByBloodGroupIgnoreCase(bloodGroup.trim());
    }

    // Register a new blood donor with validation
    public BloodDonor saveDonor(BloodDonor donor) {
        validateDonorEligibility(donor);
        return donorRepository.save(donor);
    }

    // Update donor details with validation
    public BloodDonor updateDonor(Long id, BloodDonor updated) {
        validateDonorEligibility(updated);
        return donorRepository.findById(id).map(existing -> {
            existing.setName(updated.getName());
            existing.setAge(updated.getAge());
            existing.setGender(updated.getGender());
            existing.setBloodGroup(updated.getBloodGroup());
            existing.setContactNumber(updated.getContactNumber());
            existing.setEmail(updated.getEmail());
            existing.setAddress(updated.getAddress());
            existing.setLastDonationDate(updated.getLastDonationDate());
            existing.setHealthStatus(updated.getHealthStatus());
            return donorRepository.save(existing);
        }).orElseThrow(() -> new IllegalArgumentException("Donor not found with ID: " + id));
    }

    public boolean deleteDonorById(Long id) {
        if (donorRepository.existsById(id)) {
            donorRepository.deleteById(id);
            return true;
        }
        return false;
    }

    // Validation rules for donor age, health status, and donation eligibility
    public void validateDonorEligibility(BloodDonor donor) {
        if (donor.getAge() == null || donor.getAge() < 18 || donor.getAge() > 65) {
            throw new IllegalArgumentException("Eligibility Error: Donor age must be between 18 and 65 years old.");
        }
        if (donor.getLastDonationDate() != null) {
            if (donor.getLastDonationDate().isAfter(LocalDate.now())) {
                throw new IllegalArgumentException("Invalid Date: Last donation date cannot be in the future.");
            }
        }
    }
}
