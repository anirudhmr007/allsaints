package com.example.blooddonor.service;

import com.example.blooddonor.entity.BloodDonor;
import com.example.blooddonor.repository.BloodDonorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * Service Layer: Business logic and validations for Blood Donor eligibility.
 */
@Service
public class BloodDonorService {

    @Autowired
    private BloodDonorRepository donorRepository;

    // 1. Get all registered donors
    public List<BloodDonor> getAllDonors() {
        return donorRepository.findAll();
    }

    // 2. Find donor by Donor ID
    public BloodDonor getDonorById(Long id) {
        return donorRepository.findById(id).orElse(null);
    }

    // 3. Search donors by Blood Group (e.g. O+, A+, etc.)
    public List<BloodDonor> searchByBloodGroup(String bloodGroup) {
        if (bloodGroup == null || bloodGroup.equalsIgnoreCase("ALL")) {
            return getAllDonors();
        }
        return donorRepository.findByBloodGroupIgnoreCase(bloodGroup.trim());
    }

    // 4. Register or Update donor with eligibility validation
    public String saveDonorWithValidation(BloodDonor donor) {
        // Validation 1: Donor Age must be between 18 and 65 years
        if (donor.getAge() < 18 || donor.getAge() > 65) {
            return "Error: Donor age must be between 18 and 65 years! (Entered: " + donor.getAge() + ")";
        }

        // Validation 2: Health Status check
        if (!"Fit".equalsIgnoreCase(donor.getHealthStatus()) && !"Healthy".equalsIgnoreCase(donor.getHealthStatus())) {
            return "Error: Donor health status must be 'Fit' to donate blood! (Entered: " + donor.getHealthStatus() + ")";
        }

        // Validation 3: Donation Eligibility (at least 90 days between donations)
        if (donor.getLastDonationDate() != null) {
            long daysSince = ChronoUnit.DAYS.between(donor.getLastDonationDate(), LocalDate.now());
            if (daysSince < 90) {
                return "Error: Donor is not eligible yet! Only " + daysSince + " days since last donation. Minimum 90 days required.";
            }
        }

        donorRepository.save(donor);
        return "Success: Blood donor saved successfully!";
    }

    // 5. Delete donor by Donor ID
    public void deleteDonor(Long id) {
        donorRepository.deleteById(id);
    }
}
