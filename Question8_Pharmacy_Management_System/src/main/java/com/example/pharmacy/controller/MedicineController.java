package com.example.pharmacy.controller;

import com.example.pharmacy.entity.Medicine;
import com.example.pharmacy.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class MedicineController {

    @Autowired
    private MedicineService medicineService;

    // View All Medicines
    @GetMapping({"/", "/medicines", "/medicines/list"})
    public String listMedicines(Model model) {
        List<Medicine> medicines = medicineService.getAllMedicines();
        long expiredCount = medicines.stream().filter(Medicine::isExpired).count();
        model.addAttribute("medicines", medicines);
        model.addAttribute("expiredCount", expiredCount);
        return "medicine-list";
    }

    // Show form to add new medicine
    @GetMapping("/medicines/add")
    public String showAddForm(Model model) {
        model.addAttribute("medicine", new Medicine());
        return "medicine-form";
    }

    // Save or update medicine in database
    @PostMapping("/medicines/save")
    public String saveMedicine(@ModelAttribute("medicine") Medicine medicine, RedirectAttributes redirectAttributes) {
        try {
            medicineService.saveMedicine(medicine);
            redirectAttributes.addFlashAttribute("successMessage", "Medicine '" + medicine.getMedicineName() + "' saved successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            if (medicine.getMedicineId() != null) {
                return "redirect:/medicines/edit/" + medicine.getMedicineId();
            }
            return "redirect:/medicines/add";
        }
        return "redirect:/medicines";
    }

    // Show form to edit existing medicine
    @GetMapping("/medicines/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Medicine medicine = medicineService.getMedicineById(id);
        model.addAttribute("medicine", medicine);
        return "medicine-form";
    }

    // Delete medicine by ID
    @GetMapping("/medicines/delete/{id}")
    public String deleteMedicine(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        medicineService.deleteMedicine(id);
        redirectAttributes.addFlashAttribute("successMessage", "Medicine with ID " + id + " deleted successfully!");
        return "redirect:/medicines";
    }

    // Search medicines by ID or Name
    @GetMapping("/medicines/search")
    public String searchMedicines(@RequestParam("keyword") String keyword, Model model) {
        List<Medicine> searchResults = medicineService.searchMedicines(keyword);
        long expiredCount = searchResults.stream().filter(Medicine::isExpired).count();
        model.addAttribute("medicines", searchResults);
        model.addAttribute("keyword", keyword);
        model.addAttribute("expiredCount", expiredCount);
        return "medicine-list";
    }
}
