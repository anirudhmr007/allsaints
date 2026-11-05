package com.example.banking.controller;

import com.example.banking.entity.BankAccount;
import com.example.banking.service.BankingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Online Banking System.
 */
@Controller
public class BankingController {

    @Autowired
    private BankingService bankingService;

    // 1. Display all registered customer accounts in JSP table
    @GetMapping({"/", "/accounts", "/accounts/list"})
    public String showAccountsList(Model model) {
        model.addAttribute("accounts", bankingService.getAllAccounts());
        return "account-list";
    }

    // 2. Show form to register a new customer and create bank account
    @GetMapping({"/accounts/register", "/accounts/add"})
    public String showRegisterForm(Model model) {
        BankAccount newAccount = new BankAccount();
        newAccount.setAccountNumber("ACC" + (100000 + (int)(Math.random() * 900000)));
        model.addAttribute("account", newAccount);
        return "account-form";
    }

    // 3. Save new customer account in PostgreSQL
    @PostMapping("/accounts/save")
    public String saveAccount(@ModelAttribute("account") BankAccount account, RedirectAttributes redirectAttributes) {
        bankingService.registerAccount(account);
        redirectAttributes.addFlashAttribute("message", "Bank account " + account.getAccountNumber() + " created successfully!");
        return "redirect:/accounts";
    }

    // 4. Search for a customer account using Account Number & Display Current Balance
    @GetMapping("/accounts/search")
    public String searchAccount(@RequestParam(value = "accountNumber", required = false) String accountNumber, Model model) {
        if (accountNumber != null && !accountNumber.trim().isEmpty()) {
            BankAccount account = bankingService.getAccountByNumber(accountNumber);
            List<BankAccount> resultList = new ArrayList<>();
            if (account != null) {
                resultList.add(account);
                model.addAttribute("currentBalanceMessage", "Current balance for " + account.getAccountNumber() + " is: $" + account.getAccountBalance());
            } else {
                model.addAttribute("error", "No bank account found for Account Number: " + accountNumber);
            }
            model.addAttribute("accounts", resultList);
            model.addAttribute("searchedNumber", accountNumber);
        } else {
            model.addAttribute("accounts", bankingService.getAllAccounts());
        }
        return "account-list";
    }

    // 5. Show simple Deposit & Withdraw transaction page
    @GetMapping("/accounts/transaction")
    public String showTransactionPage(@RequestParam(value = "accountNumber", required = false) String accountNumber, Model model) {
        model.addAttribute("accounts", bankingService.getAllAccounts());
        model.addAttribute("selectedAccountNumber", accountNumber);
        return "transaction";
    }

    // 6. Handle Deposit money operation
    @PostMapping("/accounts/deposit")
    public String depositMoney(@RequestParam("accountNumber") String accountNumber,
                               @RequestParam("amount") double amount,
                               RedirectAttributes redirectAttributes) {
        String result = bankingService.deposit(accountNumber, amount);
        if (result.startsWith("Error")) {
            redirectAttributes.addFlashAttribute("error", result);
        } else {
            redirectAttributes.addFlashAttribute("message", result);
        }
        return "redirect:/accounts";
    }

    // 7. Handle Withdraw money operation
    @PostMapping("/accounts/withdraw")
    public String withdrawMoney(@RequestParam("accountNumber") String accountNumber,
                                @RequestParam("amount") double amount,
                                RedirectAttributes redirectAttributes) {
        String result = bankingService.withdraw(accountNumber, amount);
        if (result.startsWith("Error")) {
            redirectAttributes.addFlashAttribute("error", result);
        } else {
            redirectAttributes.addFlashAttribute("message", result);
        }
        return "redirect:/accounts";
    }

    // 8. Delete an account
    @GetMapping("/accounts/delete/{id}")
    public String deleteAccount(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        bankingService.deleteAccount(id);
        redirectAttributes.addFlashAttribute("message", "Bank account deleted successfully!");
        return "redirect:/accounts";
    }
}
