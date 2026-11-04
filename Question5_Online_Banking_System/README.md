# Question 5: Online Banking System

A secure financial transaction and account management web application built with **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [Prerequisites](#prerequisites)
4. [PostgreSQL Database Setup](#postgresql-database-setup)
5. [Configuration](#configuration)
6. [How to Run the Application](#how-to-run-the-application)
7. [Endpoints & Operations](#endpoints--operations)
8. [Business Validation Rules](#business-validation-rules)
9. [Sample Test Data](#sample-test-data)

---

## 🏦 Overview & Features
This application simulates a core online banking system with rigorous transaction safeguards:
- **Customer Registration & Account Creation**: Creates bank accounts with AccountID, Account Number (unique), Customer Name, Age (must be 18+), Gender, Contact Number, Email, Address, Account Type (Savings/Current/Fixed Deposit), and Opening Balance.
- **Display Accounts**: Shows all customer accounts with live balance indicators in a JSP table.
- **Search Account**: Search for any customer account using Account Number.
- **Deposit Money**: Increases account balance with positive amount validation.
- **Withdraw Money**: Decreases account balance with strict overdraft prevention checks.
- **Balance Inquiry**: Dedicated query page displaying current balance for any Account Number.

---

## 🏛 MVC Architecture
```
Question5_Online_Banking_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/banking/
        │   ├── BankingApplication.java              # Main Spring Boot Runner
        │   ├── entity/BankAccount.java              # JPA Entity mapped to 'bank_accounts'
        │   ├── repository/BankAccountRepository.java# JPA Repository
        │   ├── service/BankingService.java          # Service handling deposit, withdraw, balance
        │   └── controller/BankingController.java    # Spring MVC Controller
        ├── resources/
        │   └── application.properties               # Port 8085, DB, & JSP config
        └── webapp/WEB-INF/jsp/
            ├── account-list.jsp                     # Accounts directory & search
            ├── account-form.jsp                     # Registration & update form
            ├── account-transaction.jsp              # Deposit and withdraw portal
            └── account-balance.jsp                  # Balance inquiry page
```

---

## ⚙ Prerequisites
- **JDK 17 or higher**
- **PostgreSQL 12+**
- **Maven 3.8+**

---

## 🗄 PostgreSQL Database Setup
1. Open terminal:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE banking_db;
   ```
3. Load schema and initial bank accounts:
   ```bash
   \c banking_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8085
spring.datasource.url=jdbc:postgresql://localhost:5432/banking_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🛡 Business Validation Rules
1. **Deposit Validation**:
   - The deposit amount must be greater than `$0.00`.
   - Rejects negative or zero amount inputs.
2. **Withdrawal Validation**:
   - Withdrawal amount must be greater than `$0.00`.
   - Withdrawal amount **cannot exceed** the current account balance.
   - If withdrawal amount > balance, an informative error is displayed:
     `"Insufficient funds! Requested withdrawal: $X, but current account balance is: $Y."`
3. **Customer Eligibility**:
   - Customer age must be 18 years or older.
   - Contact numbers must be exactly 10 digits.

---

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question5_Online_Banking_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8085/accounts/list`

### Option B: IDE
1. Import `Question5_Online_Banking_System` as a Maven project.
2. Run `com.example.banking.BankingApplication`.
3. Open `http://localhost:8085/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Accounts | `GET` | `/accounts/list` or `/` | Show all customer accounts |
| Register Account Form | `GET` | `/accounts/register` | Open account registration form |
| Create Account | `POST` | `/accounts/register` | Save account in PostgreSQL |
| Search Account | `GET` | `/accounts/search?accountNumber=ACC1000101` | Search account by Account Number |
| Check Balance | `GET` | `/accounts/balance?accountNumber=ACC1000101` | Dedicated balance inquiry |
| Transaction Page | `GET` | `/accounts/transaction?accountNumber=...` | Deposit/Withdraw interface |
| Process Deposit | `POST` | `/accounts/deposit` | Execute deposit transaction |
| Process Withdrawal | `POST` | `/accounts/withdraw` | Execute withdrawal with overdraft checks |
| Delete Account | `GET` | `/accounts/delete/{id}` | Close/delete account record |

---

## 🧪 Sample Test Data
| Account Number | Customer Name | Account Type | Balance | Contact |
|----------------|---------------|--------------|---------|---------|
| `ACC1000101` | Arthur Morgan | Savings | $12,500.50 | 9870001111 |
| `ACC1000102` | Sadie Adler | Current | $45,000.00 | 9870002222 |
| `ACC1000103` | John Marston | Savings | $8,200.75 | 9870003333 |
