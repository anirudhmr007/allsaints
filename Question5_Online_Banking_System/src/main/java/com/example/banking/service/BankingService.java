package com.example.banking.service;

import com.example.banking.entity.BankAccount;
import com.example.banking.repository.BankAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service Layer: Business logic & validations for Banking transactions.
 */
@Service
public class BankingService {

    @Autowired
    private BankAccountRepository accountRepository;

    // 1. Get all customer accounts
    public List<BankAccount> getAllAccounts() {
        return accountRepository.findAll();
    }

    // 2. Search customer account by Account Number
    public BankAccount getAccountByNumber(String accountNumber) {
        if (accountNumber == null) return null;
        return accountRepository.findByAccountNumber(accountNumber.trim()).orElse(null);
    }

    // 3. Register a new customer and create bank account
    public BankAccount registerAccount(BankAccount account) {
        return accountRepository.save(account);
    }

    // 4. Deposit money with validation (amount must be positive)
    public String deposit(String accountNumber, double amount) {
        if (amount <= 0) {
            return "Error: Deposit amount must be greater than $0.00!";
        }
        BankAccount account = getAccountByNumber(accountNumber);
        if (account == null) {
            return "Error: Account number " + accountNumber + " not found!";
        }
        // Update balance
        account.setAccountBalance(account.getAccountBalance() + amount);
        accountRepository.save(account);
        return "Success: Deposited $" + amount + ". New Balance is: $" + account.getAccountBalance();
    }

    // 5. Withdraw money with validation (amount > 0 and amount <= balance)
    public String withdraw(String accountNumber, double amount) {
        if (amount <= 0) {
            return "Error: Withdrawal amount must be greater than $0.00!";
        }
        BankAccount account = getAccountByNumber(accountNumber);
        if (account == null) {
            return "Error: Account number " + accountNumber + " not found!";
        }
        // Overdraft check
        if (amount > account.getAccountBalance()) {
            return "Error: Insufficient funds! Current balance is $" + account.getAccountBalance() + ", but tried to withdraw $" + amount;
        }
        // Deduct and save
        account.setAccountBalance(account.getAccountBalance() - amount);
        accountRepository.save(account);
        return "Success: Withdrew $" + amount + ". Remaining Balance is: $" + account.getAccountBalance();
    }

    // 6. Delete account
    public void deleteAccount(Long id) {
        accountRepository.deleteById(id);
    }
}
