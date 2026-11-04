package com.example.blooddonor.repository;

import com.example.blooddonor.entity.BloodDonor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BloodDonorRepository extends JpaRepository<BloodDonor, Long> {
    List<BloodDonor> findByBloodGroupIgnoreCase(String bloodGroup);
    List<BloodDonor> findByNameContainingIgnoreCase(String name);
}

