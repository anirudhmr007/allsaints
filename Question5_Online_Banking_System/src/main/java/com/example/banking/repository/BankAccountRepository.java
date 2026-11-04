package com.example.banking.repository;

import com.example.banking.entity.BankAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BankAccountRepository extends JpaRepository<BankAccount, Long> {
    Optional<BankAccount> findByAccountNumber(String accountNumber);
    List<BankAccount> findByCustomerNameContainingIgnoreCase(String customerName);
    boolean existsByAccountNumber(String accountNumber);
}

