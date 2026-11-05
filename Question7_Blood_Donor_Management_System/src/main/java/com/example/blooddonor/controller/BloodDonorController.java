package com.example.blooddonor.controller;

import com.example.blooddonor.entity.BloodDonor;
import com.example.blooddonor.service.BloodDonorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Blood Donor Management System.
 */
@Controller
public class BloodDonorController {

    @Autowired
    private BloodDonorService donorService;

    // 1. Display all registered blood donors in a JSP table
    @GetMapping({"/", "/donors", "/donors/list"})
    public String showDonorsList(Model model) {
        model.addAttribute("donors", donorService.getAllDonors());
        return "donor-list";
    }

    // 2. Show form to register a new blood donor
    @GetMapping("/donors/add")
    public String showAddDonorForm(Model model) {
        BloodDonor donor = new BloodDonor();
        donor.setHealthStatus("Fit");
        model.addAttribute("donor", donor);
        model.addAttribute("pageTitle", "Register New Blood Donor");
        return "donor-form";
    }

    // 3. Save new blood donor or update existing donor in PostgreSQL
    @PostMapping("/donors/save")
    public String saveDonor(@ModelAttribute("donor") BloodDonor donor, RedirectAttributes redirectAttributes) {
        String result = donorService.saveDonorWithValidation(donor);
        if (result.startsWith("Error")) {
            redirectAttributes.addFlashAttribute("error", result);
        } else {
            redirectAttributes.addFlashAttribute("message", result);
        }
        return "redirect:/donors";
    }

    // 4. Search for blood donors based on Blood Group
    @GetMapping("/donors/search-by-group")
    public String searchByBloodGroup(@RequestParam(value = "bloodGroup", required = false) String bloodGroup, Model model) {
        List<BloodDonor> results = donorService.searchByBloodGroup(bloodGroup);
        model.addAttribute("donors", results);
        model.addAttribute("selectedGroup", bloodGroup);
        return "donor-list";
    }

    // 5. Search for a blood donor using Donor ID
    @GetMapping("/donors/search-by-id")
    public String searchById(@RequestParam(value = "donorId", required = false) Long donorId, Model model) {
        if (donorId != null) {
            BloodDonor donor = donorService.getDonorById(donorId);
            List<BloodDonor> resultList = new ArrayList<>();
            if (donor != null) {
                resultList.add(donor);
            } else {
                model.addAttribute("error", "No donor found with Donor ID: " + donorId);
            }
            model.addAttribute("donors", resultList);
            model.addAttribute("searchedId", donorId);
        } else {
            model.addAttribute("donors", donorService.getAllDonors());
        }
        return "donor-list";
    }

    // 6. Show form to update donor details
    @GetMapping("/donors/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        BloodDonor donor = donorService.getDonorById(id);
        model.addAttribute("donor", donor);
        model.addAttribute("pageTitle", "Update Donor Details");
        return "donor-form";
    }

    // 7. Delete a donor record using Donor ID
    @GetMapping("/donors/delete/{id}")
    public String deleteDonor(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        donorService.deleteDonor(id);
        redirectAttributes.addFlashAttribute("message", "Blood donor record deleted successfully!");
        return "redirect:/donors";
    }
}
