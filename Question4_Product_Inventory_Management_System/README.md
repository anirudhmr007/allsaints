# Question 4: Product Inventory Management System

A robust inventory management web platform built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [Prerequisites](#prerequisites)
4. [PostgreSQL Database Setup](#postgresql-database-setup)
5. [Configuration](#configuration)
6. [How to Run the Application](#how-to-run-the-application)
7. [Endpoints & Operations](#endpoints--operations)
8. [Sample Test Data](#sample-test-data)

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
            ├── product-form.jsp                  # Product creation/modification form
            └── product-view.jsp                  # Full product specification view
```

---

## ⚙ Prerequisites
- **JDK 17 or higher**
- **PostgreSQL 12+** (default port 5432)
- **Apache Maven 3.8+**

---

## 🗄 PostgreSQL Database Setup
1. Open terminal:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE inventory_db;
   ```
3. Load schema and sample records:
   ```bash
   \c inventory_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8084
spring.datasource.url=jdbc:postgresql://localhost:5432/inventory_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question4_Product_Inventory_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8084/products/list`

### Option B: IDE
1. Open `Question4_Product_Inventory_Management_System` in your IDE.
2. Run `com.example.inventory.InventoryApplication`.
3. Open `http://localhost:8084/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| List Products | `GET` | `/products/list` or `/` | Show all products in JSP table |
| New Product Form | `GET` | `/products/new` | Open product registration form |
| Save Product | `POST` | `/products/new` | Save new product to PostgreSQL |
| Search Product | `GET` | `/products/search?productId=1` | Search product by Product ID |
| View Product Details | `GET` | `/products/view/{id}` | View full specifications |
| Edit Product Form | `GET` | `/products/edit/{id}` | Edit product pre-filled form |
| Update Product | `POST` | `/products/update/{id}` | Update product details |
| Delete Product | `GET` | `/products/delete/{id}` | Remove product by ID |

---

## 🧪 Sample Test Data
| ProductID | Product Name | Category | Brand | Price | Quantity | Supplier |
|-----------|--------------|----------|-------|-------|----------|----------|
| 1 | Wireless Noise-Cancelling Headphones | Electronics | Sony | $299.99 | 45 | Global Tech Distributors |
| 2 | Organic Green Tea Bags (100 pack) | Groceries | Lipton | $14.50 | 120 | Nature Leaf Suppliers |
| 3 | Ergonomic Office Chair | Furniture | Herman Miller | $450.00 | 18 | Apex Office Supplies |
