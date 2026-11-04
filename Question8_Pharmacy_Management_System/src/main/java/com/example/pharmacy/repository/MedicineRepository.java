package com.example.pharmacy.repository;

import com.example.pharmacy.entity.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
    List<Medicine> findByMedicineNameContainingIgnoreCase(String medicineName);
    List<Medicine> findByCategoryIgnoreCase(String category);
    List<Medicine> findByExpiryDateBefore(LocalDate date);
}

