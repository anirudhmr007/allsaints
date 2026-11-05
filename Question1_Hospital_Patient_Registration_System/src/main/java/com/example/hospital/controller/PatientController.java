package com.example.hospital.controller;

import com.example.hospital.entity.Patient;
import com.example.hospital.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Hospital Patient Registration.
 */
@Controller
public class PatientController {

    @Autowired
    private PatientService patientService;

    // 1. Display all registered patients in JSP table
    @GetMapping({"/", "/patients", "/patients/list"})
    public String showPatientsList(Model model) {
        List<Patient> list = patientService.getAllPatients();
        model.addAttribute("patients", list);
        return "patient-list";
    }

    // 2. Show form to register a new patient
    @GetMapping("/patients/add")
    public String showAddPatientForm(Model model) {
        model.addAttribute("patient", new Patient());
        model.addAttribute("pageTitle", "Register New Patient");
        return "patient-form";
    }

    // 3. Save new patient or update existing patient in PostgreSQL
    @PostMapping("/patients/save")
    public String savePatient(@ModelAttribute("patient") Patient patient, RedirectAttributes redirectAttributes) {
        patientService.savePatient(patient);
        redirectAttributes.addFlashAttribute("message", "Patient saved successfully!");
        return "redirect:/patients";
    }

    // 4. Search for a patient using Patient ID
    @GetMapping("/patients/search")
    public String searchPatient(@RequestParam(value = "patientId", required = false) Long patientId, Model model) {
        if (patientId != null) {
            Patient patient = patientService.getPatientById(patientId);
            List<Patient> resultList = new ArrayList<>();
            if (patient != null) {
                resultList.add(patient);
            } else {
                model.addAttribute("error", "No patient found with ID: " + patientId);
            }
            model.addAttribute("patients", resultList);
            model.addAttribute("searchedId", patientId);
        } else {
            model.addAttribute("patients", patientService.getAllPatients());
        }
        return "patient-list";
    }

    // 5. Show form to update patient details
    @GetMapping("/patients/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Patient patient = patientService.getPatientById(id);
        model.addAttribute("patient", patient);
        model.addAttribute("pageTitle", "Update Patient Details");
        return "patient-form";
    }

    // 6. Delete a patient record using Patient ID
    @GetMapping("/patients/delete/{id}")
    public String deletePatient(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        patientService.deletePatient(id);
        redirectAttributes.addFlashAttribute("message", "Patient deleted successfully!");
        return "redirect:/patients";
    }
}
