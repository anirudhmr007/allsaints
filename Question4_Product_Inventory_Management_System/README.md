# Question 4: Product Inventory Management System
### GUI Execution Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [pgAdmin 4 Database Setup (No Terminal Needed)](#-pgadmin-4-database-setup-no-terminal-needed)
4. [Spring Tools 4 for Eclipse (STS) Execution Guide](#-spring-tools-4-for-eclipse-sts-execution-guide)
5. [Endpoints & Operations](#endpoints--operations)
6. [Sample Test Data](#sample-test-data)

---

## 📦 Overview & Features
This application tracks stock supply, batches, pricing, and expiration dates for warehouse products:
- **Add New Product**: Captures ProductID (auto-generated), Product Name, Category, Brand, Description, Price, Quantity, Supplier Name, Manufacturing Date, and Expiry Date.
- **Display Registered Products**: Visualizes stock levels, categories, and expiration dates in a responsive JSP table.
- **Search Product**: Search inventory instantly by Product ID.
- **Update Product Details**: Edit stock quantities, prices, supplier details, or expiration metadata.
- **Delete Product Record**: Remove decommissioned items with confirmation guardrails.

---

## 🏛 MVC Architecture
```
Question4_Product_Inventory_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/inventory/
        │   ├── InventoryApplication.java         # Spring Boot Runner & Servlet Initializer
        │   ├── entity/Product.java               # JPA Entity mapped to 'products' table
        │   ├── repository/ProductRepository.java # Spring Data JPA Repository
        │   ├── service/ProductService.java       # Transactional Service layer
        │   └── controller/ProductController.java # Web MVC Controller
        ├── resources/
        │   └── application.properties            # Port 8084, PostgreSQL, & JSP view configuration
        └── webapp/WEB-INF/jsp/
            ├── product-list.jsp                  # Inventory overview & search
            └── product-form.jsp                  # Simple product creation & edit form
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `inventory_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `inventory_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `inventory_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question4_Product_Inventory_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables and initial products are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question4_Product_Inventory_Management_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question4_Product_Inventory_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8084
   spring.datasource.url=jdbc:postgresql://localhost:5432/inventory_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question4_Product_Inventory_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `product-inventory-management` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8084 (http) with context path '/'
Started InventoryApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8084/products/list](http://localhost:8084/products/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| List Products | `GET` | `/` or `/products` or `/products/list` | Show all products in JSP table |
| New Product Form | `GET` | `/products/add` | Open simple product registration form |
| Save / Update Product | `POST` | `/products/save` | Save new or updated product to PostgreSQL |
| Search Product | `GET` | `/products/search?productId=1` | Search product by Product ID |
| Edit Product Form | `GET` | `/products/edit/{id}` | Edit product pre-filled form |
| Delete Product | `GET` | `/products/delete/{id}` | Remove product by ID |

---

## 🧪 Sample Test Data
| ProductID | Product Name | Category | Brand | Price | Quantity | Supplier |
|-----------|--------------|----------|-------|-------|----------|----------|
| 1 | Wireless Noise-Cancelling Headphones | Electronics | Sony | $299.99 | 45 | Global Tech Distributors |
| 2 | Organic Green Tea Bags (100 pack) | Groceries | Lipton | $14.50 | 120 | Nature Leaf Suppliers |
| 3 | Ergonomic Office Chair | Furniture | Herman Miller | $450.00 | 18 | Apex Office Supplies |
