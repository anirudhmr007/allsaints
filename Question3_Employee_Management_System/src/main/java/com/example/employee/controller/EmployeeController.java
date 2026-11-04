package com.example.employee.controller;

import com.example.employee.entity.Employee;
import com.example.employee.service.EmployeeService;
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
@RequestMapping({"/", "/employees"})
public class EmployeeController {

    private final EmployeeService employeeService;

    @Autowired
    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    // Display all registered employees in a JSP table
    @GetMapping({"", "/list"})
    public String listEmployees(Model model) {
        List<Employee> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        return "employee-list";
    }

    // Show form to add a new employee
    @GetMapping("/new")
    public String showAddEmployeeForm(Model model) {
        if (!model.containsAttribute("employee")) {
            model.addAttribute("employee", new Employee());
        }
        model.addAttribute("isEdit", false);
        return "employee-form";
    }

    // Add a new employee and save details in PostgreSQL
    @PostMapping("/new")
    public String addEmployee(@Valid @ModelAttribute("employee") Employee employee,
                              BindingResult result,
                              RedirectAttributes redirectAttributes,
                              Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "employee-form";
        }
        try {
            employeeService.saveEmployee(employee);
            redirectAttributes.addFlashAttribute("successMessage", "Employee '" + employee.getName() + "' added successfully with ID: " + employee.getEmployeeId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving employee: " + e.getMessage());
            return "redirect:/employees/new";
        }
        return "redirect:/employees/list";
    }

    // Search for an employee using Employee ID
    @GetMapping("/search")
    public String searchEmployee(@RequestParam(value = "employeeId", required = false) Long employeeId,
                                 Model model) {
        if (employeeId == null) {
            return "redirect:/employees/list";
        }

        Optional<Employee> employeeOpt = employeeService.getEmployeeById(employeeId);
        List<Employee> searchResults = new ArrayList<>();
        if (employeeOpt.isPresent()) {
            searchResults.add(employeeOpt.get());
            model.addAttribute("searchSuccess", "Found employee with ID: " + employeeId);
        } else {
            model.addAttribute("searchError", "No employee found with Employee ID: " + employeeId);
        }
        model.addAttribute("employees", searchResults);
        model.addAttribute("searchedId", employeeId);
        return "employee-list";
    }

    // View detailed employee information
    @GetMapping("/view/{id}")
    public String viewEmployee(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
        if (employeeOpt.isPresent()) {
            model.addAttribute("employee", employeeOpt.get());
            return "employee-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Employee not found with ID: " + id);
        return "redirect:/employees/list";
    }

    // Show edit employee form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
        if (employeeOpt.isPresent()) {
            model.addAttribute("employee", employeeOpt.get());
            model.addAttribute("isEdit", true);
            return "employee-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Employee not found with ID: " + id);
        return "redirect:/employees/list";
    }

    // Update employee details
    @PostMapping("/update/{id}")
    public String updateEmployee(@PathVariable("id") Long id,
                                 @Valid @ModelAttribute("employee") Employee employee,
                                 BindingResult result,
                                 RedirectAttributes redirectAttributes,
                                 Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "employee-form";
        }
        try {
            employeeService.updateEmployee(id, employee);
            redirectAttributes.addFlashAttribute("successMessage", "Employee ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating employee: " + e.getMessage());
        }
        return "redirect:/employees/list";
    }

    // Delete an employee record using Employee ID
    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = employeeService.deleteEmployeeById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Employee record with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Employee with ID " + id + " does not exist.");
        }
        return "redirect:/employees/list";
    }
}
