# Question 5: Online Banking System
### GUI Execution Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [pgAdmin 4 Database Setup (No Terminal Needed)](#-pgadmin-4-database-setup-no-terminal-needed)
4. [Spring Tools 4 for Eclipse (STS) Execution Guide](#-spring-tools-4-for-eclipse-sts-execution-guide)
5. [Endpoints & Operations](#endpoints--operations)
6. [Business Validation Rules](#business-validation-rules)
7. [Sample Test Data](#sample-test-data)

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
            ├── account-form.jsp                     # Registration form
            └── transaction.jsp                      # Clean Deposit and withdraw portal
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `banking_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `banking_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `banking_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question5_Online_Banking_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables and initial accounts are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question5_Online_Banking_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question5_Online_Banking_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8085
   spring.datasource.url=jdbc:postgresql://localhost:5432/banking_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question5_Online_Banking_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `online-banking-system` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8085 (http) with context path '/'
Started BankingApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8085/accounts/list](http://localhost:8085/accounts/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

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

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Accounts | `GET` | `/` or `/accounts` or `/accounts/list` | Show all customer accounts |
| Register Account Form | `GET` | `/accounts/register` or `/accounts/add` | Open account registration form |
| Create Account | `POST` | `/accounts/save` | Save account in PostgreSQL |
| Search Account | `GET` | `/accounts/search?accountNumber=ACC1000101` | Search account by Account Number |
| Transaction Page | `GET` | `/accounts/transaction/{id}` | Simple Deposit/Withdraw interface |
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
