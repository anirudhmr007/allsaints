package com.example.employee.controller;

import com.example.employee.entity.Employee;
import com.example.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Employee Management.
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    // 1. Display all registered employees in a JSP table
    @GetMapping({"/", "/employees", "/employees/list"})
    public String showEmployeesList(Model model) {
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "employee-list";
    }

    // 2. Show form to add a new employee
    @GetMapping("/employees/add")
    public String showAddEmployeeForm(Model model) {
        model.addAttribute("employee", new Employee());
        model.addAttribute("pageTitle", "Add New Employee");
        return "employee-form";
    }

    // 3. Save new employee or update existing employee
    @PostMapping("/employees/save")
    public String saveEmployee(@ModelAttribute("employee") Employee employee, RedirectAttributes redirectAttributes) {
        employeeService.saveEmployee(employee);
        redirectAttributes.addFlashAttribute("message", "Employee saved successfully!");
        return "redirect:/employees";
    }

    // 4. Search for an employee using Employee ID
    @GetMapping("/employees/search")
    public String searchEmployee(@RequestParam(value = "employeeId", required = false) Long employeeId, Model model) {
        if (employeeId != null) {
            Employee employee = employeeService.getEmployeeById(employeeId);
            List<Employee> resultList = new ArrayList<>();
            if (employee != null) {
                resultList.add(employee);
            } else {
                model.addAttribute("error", "No employee found with ID: " + employeeId);
            }
            model.addAttribute("employees", resultList);
            model.addAttribute("searchedId", employeeId);
        } else {
            model.addAttribute("employees", employeeService.getAllEmployees());
        }
        return "employee-list";
    }

    // 5. Show form to update employee details
    @GetMapping("/employees/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Employee employee = employeeService.getEmployeeById(id);
        model.addAttribute("employee", employee);
        model.addAttribute("pageTitle", "Update Employee Details");
        return "employee-form";
    }

    // 6. Delete an employee record using Employee ID
    @GetMapping("/employees/delete/{id}")
    public String deleteEmployee(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        employeeService.deleteEmployee(id);
        redirectAttributes.addFlashAttribute("message", "Employee deleted successfully!");
        return "redirect:/employees";
    }
}
