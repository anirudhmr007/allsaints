package com.example.pharmacy.service;

import com.example.pharmacy.entity.Medicine;
import com.example.pharmacy.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MedicineService {

    @Autowired
    private MedicineRepository medicineRepository;

    // Retrieve all medicines from database
    public List<Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    // Find a medicine by primary key
    public Medicine getMedicineById(Long id) {
        return medicineRepository.findById(id).orElse(null);
    }

    // Save or update medicine with basic validation
    public void saveMedicine(Medicine medicine) {
        if (medicine.getQuantity() == null || medicine.getQuantity() < 0) {
            throw new IllegalArgumentException("Negative stock quantities are strictly prohibited! Quantity must be 0 or greater.");
        }
        if (medicine.getPrice() == null || medicine.getPrice() <= 0) {
            throw new IllegalArgumentException("Price must be greater than 0.");
        }
        medicineRepository.save(medicine);
    }

    // Delete medicine by ID
    public void deleteMedicine(Long id) {
        medicineRepository.deleteById(id);
    }

    // Search medicines by ID or Name
    public List<Medicine> searchMedicines(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllMedicines();
        }

        String query = keyword.trim();

        // 1. Check if user typed a number (Medicine ID)
        try {
            Long id = Long.parseLong(query);
            Medicine medicine = getMedicineById(id);
            if (medicine != null) {
                List<Medicine> list = new ArrayList<>();
                list.add(medicine);
                return list;
            }
        } catch (NumberFormatException ignored) {
            // Not a numeric ID, search by name
        }

        // 2. Search by Medicine Name
        return medicineRepository.findByMedicineNameContainingIgnoreCase(query);
    }
}
