package com.example.blooddonor.controller;

import com.example.blooddonor.entity.BloodDonor;
import com.example.blooddonor.service.BloodDonorService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping({"/", "/donors"})
public class BloodDonorController {

    private final BloodDonorService donorService;

    @Autowired
    public BloodDonorController(BloodDonorService donorService) {
        this.donorService = donorService;
    }

    // Display all registered blood donors in a JSP table
    @GetMapping({"", "/list"})
    public String listDonors(Model model) {
        List<BloodDonor> donors = donorService.getAllDonors();
        model.addAttribute("donors", donors);
        return "donor-list";
    }

    // Show form to register a new blood donor
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        if (!model.containsAttribute("donor")) {
            BloodDonor donor = new BloodDonor();
            donor.setHealthStatus("Fit");
            model.addAttribute("donor", donor);
        }
        model.addAttribute("isEdit", false);
        return "donor-form";
    }

    // Register a new blood donor and save details in PostgreSQL
    @PostMapping("/register")
    public String registerDonor(@Valid @ModelAttribute("donor") BloodDonor donor,
                                BindingResult result,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "donor-form";
        }
        try {
            donorService.saveDonor(donor);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Blood Donor '" + donor.getName() + " (" + donor.getBloodGroup() + ")' registered successfully with ID: " + donor.getDonorId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/donors/register";
        }
        return "redirect:/donors/list";
    }

    // Search for blood donors based on Blood Group
    @GetMapping("/search-by-group")
    public String searchByBloodGroup(@RequestParam(value = "bloodGroup", required = false) String bloodGroup,
                                     Model model) {
        if (bloodGroup == null || bloodGroup.trim().isEmpty() || "ALL".equalsIgnoreCase(bloodGroup.trim())) {
            return "redirect:/donors/list";
        }

        List<BloodDonor> donors = donorService.searchDonorsByBloodGroup(bloodGroup);
        model.addAttribute("donors", donors);
        model.addAttribute("selectedGroup", bloodGroup.trim());
        if (donors.isEmpty()) {
            model.addAttribute("searchError", "No registered donors found with Blood Group: " + bloodGroup);
        } else {
            model.addAttribute("searchSuccess", "Found " + donors.size() + " donor(s) with Blood Group: " + bloodGroup);
        }
        return "donor-list";
    }

    // Search by Donor ID
    @GetMapping("/search-by-id")
    public String searchById(@RequestParam(value = "donorId", required = false) Long donorId,
                             Model model) {
        if (donorId == null) {
            return "redirect:/donors/list";
        }

        Optional<BloodDonor> donorOpt = donorService.getDonorById(donorId);
        List<BloodDonor> searchResults = new ArrayList<>();
        if (donorOpt.isPresent()) {
            searchResults.add(donorOpt.get());
            model.addAttribute("searchSuccess", "Found donor record with ID: " + donorId);
        } else {
            model.addAttribute("searchError", "No donor found with Donor ID: " + donorId);
        }
        model.addAttribute("donors", searchResults);
        model.addAttribute("searchedId", donorId);
        return "donor-list";
    }

    // View donor details
    @GetMapping("/view/{id}")
    public String viewDonor(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<BloodDonor> donorOpt = donorService.getDonorById(id);
        if (donorOpt.isPresent()) {
            model.addAttribute("donor", donorOpt.get());
            return "donor-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Donor not found with ID: " + id);
        return "redirect:/donors/list";
    }

    // Show edit donor form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<BloodDonor> donorOpt = donorService.getDonorById(id);
        if (donorOpt.isPresent()) {
            model.addAttribute("donor", donorOpt.get());
            model.addAttribute("isEdit", true);
            return "donor-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Donor not found with ID: " + id);
        return "redirect:/donors/list";
    }

    // Update donor details
    @PostMapping("/update/{id}")
    public String updateDonor(@PathVariable("id") Long id,
                              @Valid @ModelAttribute("donor") BloodDonor donor,
                              BindingResult result,
                              RedirectAttributes redirectAttributes,
                              Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "donor-form";
        }
        try {
            donorService.updateDonor(id, donor);
            redirectAttributes.addFlashAttribute("successMessage", "Donor ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating donor: " + e.getMessage());
        }
        return "redirect:/donors/list";
    }

    // Delete a donor record using Donor ID
    @GetMapping("/delete/{id}")
    public String deleteDonor(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = donorService.deleteDonorById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Blood donor record with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Donor record with ID " + id + " not found.");
        }
        return "redirect:/donors/list";
    }
}
