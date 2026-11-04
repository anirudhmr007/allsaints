package com.example.banking.service;

import com.example.banking.entity.BankAccount;
import com.example.banking.repository.BankAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BankingService {

    private final BankAccountRepository bankAccountRepository;

    @Autowired
    public BankingService(BankAccountRepository bankAccountRepository) {
        this.bankAccountRepository = bankAccountRepository;
    }

    // Register a new customer and create bank account
    public BankAccount createAccount(BankAccount account) {
        if (account.getAccountNumber() == null || account.getAccountNumber().trim().isEmpty()) {
            // Generate a default unique account number if not provided
            account.setAccountNumber("ACC" + System.currentTimeMillis() % 1000000000L);
        }
        if (bankAccountRepository.existsByAccountNumber(account.getAccountNumber())) {
            throw new IllegalArgumentException("Account Number '" + account.getAccountNumber() + "' is already in use.");
        }
        if (account.getAccountBalance() == null) {
            account.setAccountBalance(0.0);
        }
        return bankAccountRepository.save(account);
    }

    // Display all registered customer accounts
    public List<BankAccount> getAllAccounts() {
        return bankAccountRepository.findAll();
    }

    // Search for a customer account using Account Number
    public Optional<BankAccount> getAccountByNumber(String accountNumber) {
        return bankAccountRepository.findByAccountNumber(accountNumber.trim());
    }

    // Search for a customer account using ID
    public Optional<BankAccount> getAccountById(Long id) {
        return bankAccountRepository.findById(id);
    }

    // Deposit money into a bank account with validation
    public BankAccount depositMoney(String accountNumber, double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Deposit amount must be strictly greater than $0.00.");
        }
        BankAccount account = bankAccountRepository.findByAccountNumber(accountNumber.trim())
                .orElseThrow(() -> new IllegalArgumentException("Bank Account not found with number: " + accountNumber));

        double newBalance = account.getAccountBalance() + amount;
        account.setAccountBalance(Math.round(newBalance * 100.0) / 100.0);
        return bankAccountRepository.save(account);
    }

    // Withdraw money from a bank account with validation
    public BankAccount withdrawMoney(String accountNumber, double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Withdrawal amount must be strictly greater than $0.00.");
        }
        BankAccount account = bankAccountRepository.findByAccountNumber(accountNumber.trim())
                .orElseThrow(() -> new IllegalArgumentException("Bank Account not found with number: " + accountNumber));

        if (amount > account.getAccountBalance()) {
            throw new IllegalArgumentException("Insufficient funds! Requested withdrawal: $" + String.format("%.2f", amount)
                    + ", but current account balance is: $" + String.format("%.2f", account.getAccountBalance()) + ".");
        }

        double newBalance = account.getAccountBalance() - amount;
        account.setAccountBalance(Math.round(newBalance * 100.0) / 100.0);
        return bankAccountRepository.save(account);
    }

    // Display current account balance for a given Account Number
    public Double getBalance(String accountNumber) {
        return bankAccountRepository.findByAccountNumber(accountNumber.trim())
                .map(BankAccount::getAccountBalance)
                .orElseThrow(() -> new IllegalArgumentException("Bank Account not found with number: " + accountNumber));
    }

    // Update customer account
    public BankAccount updateAccount(Long id, BankAccount updated) {
        return bankAccountRepository.findById(id).map(existing -> {
            existing.setCustomerName(updated.getCustomerName());
            existing.setAge(updated.getAge());
            existing.setGender(updated.getGender());
            existing.setContactNumber(updated.getContactNumber());
            existing.setEmail(updated.getEmail());
            existing.setAddress(updated.getAddress());
            existing.setAccountType(updated.getAccountType());
            return bankAccountRepository.save(existing);
        }).orElseThrow(() -> new IllegalArgumentException("Account not found with ID: " + id));
    }

    // Delete customer account
    public boolean deleteAccountById(Long id) {
        if (bankAccountRepository.existsById(id)) {
            bankAccountRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
