package com.example.pharmacy.service;

import com.example.pharmacy.entity.Medicine;
import com.example.pharmacy.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class MedicineService {

    private final MedicineRepository medicineRepository;

    @Autowired
    public MedicineService(MedicineRepository medicineRepository) {
        this.medicineRepository = medicineRepository;
    }

    public List<Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    public Optional<Medicine> getMedicineById(Long id) {
        return medicineRepository.findById(id);
    }

    // Search by ID or Name
    public List<Medicine> searchMedicines(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllMedicines();
        }
        String cleanQuery = query.trim();

        // Check if query is numeric ID
        try {
            Long id = Long.parseLong(cleanQuery);
            Optional<Medicine> medOpt = medicineRepository.findById(id);
            if (medOpt.isPresent()) {
                List<Medicine> result = new ArrayList<>();
                result.add(medOpt.get());
                return result;
            }
        } catch (NumberFormatException ignored) {
            // Not a pure number, continue with name search
        }

        return medicineRepository.findByMedicineNameContainingIgnoreCase(cleanQuery);
    }

    // Add New Medicine with strict validations
    public Medicine saveMedicine(Medicine medicine) {
        validateMedicine(medicine);
        return medicineRepository.save(medicine);
    }

    // Update Medicine Details
    public Medicine updateMedicine(Long id, Medicine updated) {
        validateMedicine(updated);
        return medicineRepository.findById(id).map(existing -> {
            existing.setMedicineName(updated.getMedicineName());
            existing.setCategory(updated.getCategory());
            existing.setManufacturer(updated.getManufacturer());
            existing.setBatchNumber(updated.getBatchNumber());
            existing.setPrice(updated.getPrice());
            existing.setQuantity(updated.getQuantity());
            existing.setManufacturingDate(updated.getManufacturingDate());
            existing.setExpiryDate(updated.getExpiryDate());
            existing.setSupplierName(updated.getSupplierName());
            return medicineRepository.save(existing);
        }).orElseThrow(() -> new IllegalArgumentException("Medicine not found with ID: " + id));
    }

    public boolean deleteMedicineById(Long id) {
        if (medicineRepository.existsById(id)) {
            medicineRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public List<Medicine> getExpiredMedicines() {
        return medicineRepository.findByExpiryDateBefore(LocalDate.now());
    }

    // Validation: prevent negative stock quantities, invalid dates, and invalid price
    private void validateMedicine(Medicine medicine) {
        if (medicine.getQuantity() == null || medicine.getQuantity() < 0) {
            throw new IllegalArgumentException("Validation Error: Negative stock quantities are strictly prohibited. Quantity must be 0 or more.");
        }
        if (medicine.getPrice() == null || medicine.getPrice() <= 0) {
            throw new IllegalArgumentException("Validation Error: Medicine price must be strictly greater than $0.00.");
        }
        if (medicine.getManufacturingDate() != null && medicine.getExpiryDate() != null) {
            if (medicine.getExpiryDate().isBefore(medicine.getManufacturingDate())) {
                throw new IllegalArgumentException("Validation Error: Expiry date cannot be prior to manufacturing date.");
            }
        }
    }
}

