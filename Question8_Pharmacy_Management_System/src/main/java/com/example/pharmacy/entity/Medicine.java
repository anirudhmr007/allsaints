package com.example.pharmacy.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "medicines")
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "medicine_id")
    private Long medicineId;

    @NotBlank(message = "Medicine name is required")
    @Size(min = 2, max = 150, message = "Medicine name must be between 2 and 150 characters")
    @Column(name = "medicine_name", nullable = false)
    private String medicineName;

    @NotBlank(message = "Category is required")
    @Column(name = "category", nullable = false)
    private String category;

    @NotBlank(message = "Manufacturer is required")
    @Column(name = "manufacturer", nullable = false)
    private String manufacturer;

    @NotBlank(message = "Batch number is required")
    @Column(name = "batch_number", nullable = false)
    private String batchNumber;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.01", message = "Price must be strictly positive")
    @Column(name = "price", nullable = false)
    private Double price;

    @NotNull(message = "Quantity is required")
    @Min(value = 0, message = "Negative stock quantities are strictly prohibited")
    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @NotNull(message = "Manufacturing date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "manufacturing_date", nullable = false)
    private LocalDate manufacturingDate;

    @NotNull(message = "Expiry date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "expiry_date", nullable = false)
    private LocalDate expiryDate;

    @NotBlank(message = "Supplier name is required")
    @Column(name = "supplier_name", nullable = false)
    private String supplierName;

    public Medicine() {
    }

    public Medicine(String medicineName, String category, String manufacturer, String batchNumber, Double price, Integer quantity, LocalDate manufacturingDate, LocalDate expiryDate, String supplierName) {
        this.medicineName = medicineName;
        this.category = category;
        this.manufacturer = manufacturer;
        this.batchNumber = batchNumber;
        this.price = price;
        this.quantity = quantity;
        this.manufacturingDate = manufacturingDate;
        this.expiryDate = expiryDate;
        this.supplierName = supplierName;
    }

    public Long getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(Long medicineId) {
        this.medicineId = medicineId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    // Expiry and Stock Validation Helpers
    public boolean isExpired() {
        return expiryDate != null && expiryDate.isBefore(LocalDate.now());
    }

    public Long getDaysUntilExpiry() {
        if (expiryDate == null) {
            return null;
        }
        return ChronoUnit.DAYS.between(LocalDate.now(), expiryDate);
    }

    public boolean isStockAvailable() {
        return quantity != null && quantity > 0;
    }

    @Override
    public String toString() {
        return "Medicine{" +
                "medicineId=" + medicineId +
                ", medicineName='" + medicineName + '\'' +
                ", category='" + category + '\'' +
                ", batchNumber='" + batchNumber + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", expiryDate=" + expiryDate +
                '}';
    }
}

