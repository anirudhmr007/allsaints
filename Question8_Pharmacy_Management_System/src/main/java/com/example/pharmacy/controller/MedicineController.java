package com.example.pharmacy.controller;

import com.example.pharmacy.entity.Medicine;
import com.example.pharmacy.service.MedicineService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping({"/", "/medicines"})
public class MedicineController {

    private final MedicineService medicineService;

    @Autowired
    public MedicineController(MedicineService medicineService) {
        this.medicineService = medicineService;
    }

    // View All Medicines in a JSP table
    @GetMapping({"", "/list"})
    public String listMedicines(Model model) {
        List<Medicine> medicines = medicineService.getAllMedicines();
        long expiredCount = medicines.stream().filter(Medicine::isExpired).count();
        model.addAttribute("medicines", medicines);
        model.addAttribute("expiredCount", expiredCount);
        return "medicine-list";
    }

    // Show form to add new medicine
    @GetMapping("/new")
    public String showAddMedicineForm(Model model) {
        if (!model.containsAttribute("medicine")) {
            model.addAttribute("medicine", new Medicine());
        }
        model.addAttribute("isEdit", false);
        return "medicine-form";
    }

    // Add New Medicine and save details in PostgreSQL
    @PostMapping("/new")
    public String saveMedicine(@Valid @ModelAttribute("medicine") Medicine medicine,
                               BindingResult result,
                               RedirectAttributes redirectAttributes,
                               Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "medicine-form";
        }
        try {
            medicineService.saveMedicine(medicine);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Medicine '" + medicine.getMedicineName() + "' registered successfully with ID: " + medicine.getMedicineId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/medicines/new";
        }
        return "redirect:/medicines/list";
    }

    // Search Medicines: Find medicines using Medicine ID or Medicine Name
    @GetMapping("/search")
    public String searchMedicines(@RequestParam(value = "query", required = false) String query,
                                  Model model) {
        if (query == null || query.trim().isEmpty()) {
            return "redirect:/medicines/list";
        }

        List<Medicine> searchResults = medicineService.searchMedicines(query);
        long expiredCount = searchResults.stream().filter(Medicine::isExpired).count();
        model.addAttribute("medicines", searchResults);
        model.addAttribute("searchQuery", query);
        model.addAttribute("expiredCount", expiredCount);

        if (searchResults.isEmpty()) {
            model.addAttribute("searchError", "No medicine records found matching: '" + query + "'");
        } else {
            model.addAttribute("searchSuccess", "Found " + searchResults.size() + " medicine record(s) matching: '" + query + "'");
        }
        return "medicine-list";
    }

    // View Medicine Details
    @GetMapping("/view/{id}")
    public String viewMedicine(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Medicine> medicineOpt = medicineService.getMedicineById(id);
        if (medicineOpt.isPresent()) {
            model.addAttribute("medicine", medicineOpt.get());
            return "medicine-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Medicine not found with ID: " + id);
        return "redirect:/medicines/list";
    }

    // Show edit medicine form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Medicine> medicineOpt = medicineService.getMedicineById(id);
        if (medicineOpt.isPresent()) {
            model.addAttribute("medicine", medicineOpt.get());
            model.addAttribute("isEdit", true);
            return "medicine-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Medicine not found with ID: " + id);
        return "redirect:/medicines/list";
    }

    // Update Medicine Details
    @PostMapping("/update/{id}")
    public String updateMedicine(@PathVariable("id") Long id,
                                 @Valid @ModelAttribute("medicine") Medicine medicine,
                                 BindingResult result,
                                 RedirectAttributes redirectAttributes,
                                 Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "medicine-form";
        }
        try {
            medicineService.updateMedicine(id, medicine);
            redirectAttributes.addFlashAttribute("successMessage", "Medicine ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating medicine: " + e.getMessage());
        }
        return "redirect:/medicines/list";
    }

    // Delete Medicine using Medicine ID
    @GetMapping("/delete/{id}")
    public String deleteMedicine(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = medicineService.deleteMedicineById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Medicine record with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Medicine with ID " + id + " not found.");
        }
        return "redirect:/medicines/list";
    }
}
