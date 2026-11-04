package com.example.banking.controller;

import com.example.banking.entity.BankAccount;
import com.example.banking.service.BankingService;
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
@RequestMapping({"/", "/accounts"})
public class BankingController {

    private final BankingService bankingService;

    @Autowired
    public BankingController(BankingService bankingService) {
        this.bankingService = bankingService;
    }

    // Display all registered customer accounts in a JSP table
    @GetMapping({"", "/list"})
    public String listAccounts(Model model) {
        List<BankAccount> accounts = bankingService.getAllAccounts();
        model.addAttribute("accounts", accounts);
        return "account-list";
    }

    // Show form to register a new customer and create a bank account
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        if (!model.containsAttribute("account")) {
            BankAccount account = new BankAccount();
            account.setAccountNumber("ACC" + (1000100 + (long)(Math.random() * 90000)));
            account.setAccountBalance(0.0);
            model.addAttribute("account", account);
        }
        model.addAttribute("isEdit", false);
        return "account-form";
    }

    // Register a new customer and create bank account in PostgreSQL
    @PostMapping("/register")
    public String registerAccount(@Valid @ModelAttribute("account") BankAccount account,
                                  BindingResult result,
                                  RedirectAttributes redirectAttributes,
                                  Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "account-form";
        }
        try {
            bankingService.createAccount(account);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Customer '" + account.getCustomerName() + "' registered successfully! Bank Account Number: " + account.getAccountNumber());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating bank account: " + e.getMessage());
            return "redirect:/accounts/register";
        }
        return "redirect:/accounts/list";
    }

    // Search for a customer account using Account Number
    @GetMapping("/search")
    public String searchAccount(@RequestParam(value = "accountNumber", required = false) String accountNumber,
                                Model model) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return "redirect:/accounts/list";
        }

        Optional<BankAccount> accountOpt = bankingService.getAccountByNumber(accountNumber);
        List<BankAccount> searchResults = new ArrayList<>();
        if (accountOpt.isPresent()) {
            searchResults.add(accountOpt.get());
            model.addAttribute("searchSuccess", "Found bank account for Account Number: " + accountNumber);
        } else {
            model.addAttribute("searchError", "No bank account found with Account Number: " + accountNumber);
        }
        model.addAttribute("accounts", searchResults);
        model.addAttribute("searchedNumber", accountNumber);
        return "account-list";
    }

    // Display current account balance for a given Account Number
    @GetMapping("/balance")
    public String checkBalance(@RequestParam(value = "accountNumber", required = false) String accountNumber,
                               Model model) {
        if (accountNumber != null && !accountNumber.trim().isEmpty()) {
            Optional<BankAccount> accountOpt = bankingService.getAccountByNumber(accountNumber);
            if (accountOpt.isPresent()) {
                model.addAttribute("account", accountOpt.get());
            } else {
                model.addAttribute("errorMessage", "Account not found with Account Number: " + accountNumber);
            }
        }
        return "account-balance";
    }

    // Show Deposit / Withdraw transaction page
    @GetMapping("/transaction")
    public String showTransactionPage(@RequestParam(value = "accountNumber", required = false) String accountNumber,
                                      @RequestParam(value = "type", defaultValue = "deposit") String type,
                                      Model model) {
        if (accountNumber != null && !accountNumber.trim().isEmpty()) {
            bankingService.getAccountByNumber(accountNumber).ifPresent(acc -> model.addAttribute("account", acc));
        }
        model.addAttribute("allAccounts", bankingService.getAllAccounts());
        model.addAttribute("selectedNumber", accountNumber);
        model.addAttribute("transType", type);
        return "account-transaction";
    }

    // Deposit money into a bank account and update account balance
    @PostMapping("/deposit")
    public String depositMoney(@RequestParam("accountNumber") String accountNumber,
                               @RequestParam("amount") Double amount,
                               RedirectAttributes redirectAttributes) {
        try {
            BankAccount updated = bankingService.depositMoney(accountNumber, amount);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Successfully deposited $" + String.format("%.2f", amount) + " into Account " + accountNumber + ". New Balance: $" + String.format("%.2f", updated.getAccountBalance()));
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Deposit Failed: " + e.getMessage());
            return "redirect:/accounts/transaction?accountNumber=" + accountNumber + "&type=deposit";
        }
        return "redirect:/accounts/list";
    }

    // Withdraw money from a bank account and update account balance
    @PostMapping("/withdraw")
    public String withdrawMoney(@RequestParam("accountNumber") String accountNumber,
                                @RequestParam("amount") Double amount,
                                RedirectAttributes redirectAttributes) {
        try {
            BankAccount updated = bankingService.withdrawMoney(accountNumber, amount);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Successfully withdrew $" + String.format("%.2f", amount) + " from Account " + accountNumber + ". Remaining Balance: $" + String.format("%.2f", updated.getAccountBalance()));
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Withdrawal Failed: " + e.getMessage());
            return "redirect:/accounts/transaction?accountNumber=" + accountNumber + "&type=withdraw";
        }
        return "redirect:/accounts/list";
    }

    // Edit account form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<BankAccount> accountOpt = bankingService.getAccountById(id);
        if (accountOpt.isPresent()) {
            model.addAttribute("account", accountOpt.get());
            model.addAttribute("isEdit", true);
            return "account-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Account not found with ID: " + id);
        return "redirect:/accounts/list";
    }

    // Update account
    @PostMapping("/update/{id}")
    public String updateAccount(@PathVariable("id") Long id,
                                @Valid @ModelAttribute("account") BankAccount account,
                                BindingResult result,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "account-form";
        }
        try {
            bankingService.updateAccount(id, account);
            redirectAttributes.addFlashAttribute("successMessage", "Account details for " + account.getAccountNumber() + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating account: " + e.getMessage());
        }
        return "redirect:/accounts/list";
    }

    // Delete account
    @GetMapping("/delete/{id}")
    public String deleteAccount(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = bankingService.deleteAccountById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Account ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Account ID " + id + " not found.");
        }
        return "redirect:/accounts/list";
    }
}

