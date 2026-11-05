package com.example.inventory.entity;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;

/**
 * Product Entity represents a product in the warehouse inventory.
 * Table: products
 */
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long productId;

    @Column(name = "product_name", nullable = false)
    private String productName;

    @Column(name = "category", nullable = false)
    private String category;

    @Column(name = "brand", nullable = false)
    private String brand;

    @Column(name = "description")
    private String description;

    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "supplier_name", nullable = false)
    private String supplierName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "manufacturing_date", nullable = false)
    private LocalDate manufacturingDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "expiry_date", nullable = false)
    private LocalDate expiryDate;

    public Product() {
    }

    public Product(String productName, String category, String brand, String description, double price, int quantity, String supplierName, LocalDate manufacturingDate, LocalDate expiryDate) {
        this.productName = productName;
        this.category = category;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.supplierName = supplierName;
        this.manufacturingDate = manufacturingDate;
        this.expiryDate = expiryDate;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public LocalDate getManufacturingDate() {
        return manufacturingDate;
    }

    public void setManufacturingDate(LocalDate manufacturingDate) {
        this.manufacturingDate = manufacturingDate;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }
}
