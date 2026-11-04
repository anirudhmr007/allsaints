package com.example.hospital.controller;

import com.example.hospital.entity.Patient;
import com.example.hospital.service.PatientService;
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
@RequestMapping({"/", "/patients"})
public class PatientController {

    private final PatientService patientService;

    @Autowired
    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    // Display all registered patients in a JSP table
    @GetMapping({"", "/list"})
    public String listPatients(Model model) {
        List<Patient> patients = patientService.getAllPatients();
        model.addAttribute("patients", patients);
        return "patient-list";
    }

    // Show form to register a new patient
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        if (!model.containsAttribute("patient")) {
            model.addAttribute("patient", new Patient());
        }
        model.addAttribute("isEdit", false);
        return "patient-form";
    }

    // Save newly registered patient
    @PostMapping("/register")
    public String registerPatient(@Valid @ModelAttribute("patient") Patient patient,
                                  BindingResult result,
                                  RedirectAttributes redirectAttributes,
                                  Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "patient-form";
        }
        patientService.savePatient(patient);
        redirectAttributes.addFlashAttribute("successMessage", "Patient registered successfully with ID: " + patient.getPatientId());
        return "redirect:/patients/list";
    }

    // Search for a patient using Patient ID
    @GetMapping("/search")
    public String searchPatient(@RequestParam(value = "patientId", required = false) Long patientId,
                                Model model) {
        if (patientId == null) {
            return "redirect:/patients/list";
        }

        Optional<Patient> patientOpt = patientService.getPatientById(patientId);
        List<Patient> searchResults = new ArrayList<>();
        if (patientOpt.isPresent()) {
            searchResults.add(patientOpt.get());
            model.addAttribute("searchSuccess", "Found patient with ID: " + patientId);
        } else {
            model.addAttribute("searchError", "No patient found with Patient ID: " + patientId);
        }
        model.addAttribute("patients", searchResults);
        model.addAttribute("searchedId", patientId);
        return "patient-list";
    }

    // View detailed information of a patient
    @GetMapping("/view/{id}")
    public String viewPatient(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Patient> patientOpt = patientService.getPatientById(id);
        if (patientOpt.isPresent()) {
            model.addAttribute("patient", patientOpt.get());
            return "patient-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Patient not found with ID: " + id);
        return "redirect:/patients/list";
    }

    // Show edit patient form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Patient> patientOpt = patientService.getPatientById(id);
        if (patientOpt.isPresent()) {
            model.addAttribute("patient", patientOpt.get());
            model.addAttribute("isEdit", true);
            return "patient-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Patient not found with ID: " + id);
        return "redirect:/patients/list";
    }

    // Update patient details
    @PostMapping("/update/{id}")
    public String updatePatient(@PathVariable("id") Long id,
                                @Valid @ModelAttribute("patient") Patient patient,
                                BindingResult result,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "patient-form";
        }
        try {
            patientService.updatePatient(id, patient);
            redirectAttributes.addFlashAttribute("successMessage", "Patient ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating patient: " + e.getMessage());
        }
        return "redirect:/patients/list";
    }

    // Delete a patient record using Patient ID
    @GetMapping("/delete/{id}")
    public String deletePatient(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = patientService.deletePatientById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Patient record with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Patient record with ID " + id + " does not exist.");
        }
        return "redirect:/patients/list";
    }
}
