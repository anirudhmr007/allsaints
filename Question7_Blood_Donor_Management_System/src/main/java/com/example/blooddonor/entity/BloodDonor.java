package com.example.blooddonor.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "blood_donors")
public class BloodDonor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "donor_id")
    private Long donorId;

    @NotBlank(message = "Donor name is required")
    @Size(min = 2, max = 100, message = "Name must be between 2 and 100 characters")
    @Column(name = "name", nullable = false)
    private String name;

    @NotNull(message = "Age is required")
    @Min(value = 18, message = "Blood donor must be at least 18 years old")
    @Max(value = 65, message = "Blood donor must not exceed 65 years of age")
    @Column(name = "age", nullable = false)
    private Integer age;

    @NotBlank(message = "Gender is required")
    @Column(name = "gender", nullable = false)
    private String gender;

    @NotBlank(message = "Blood group is required")
    @Column(name = "blood_group", nullable = false)
    private String bloodGroup;

    @NotBlank(message = "Contact number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Contact number must be exactly 10 digits")
    @Column(name = "contact_number", nullable = false)
    private String contactNumber;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Column(name = "email", nullable = false)
    private String email;

    @NotBlank(message = "Address is required")
    @Column(name = "address", nullable = false)
    private String address;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "last_donation_date")
    private LocalDate lastDonationDate;

    @NotBlank(message = "Health status is required")
    @Column(name = "health_status", nullable = false)
    private String healthStatus;

    public BloodDonor() {
    }

    public BloodDonor(String name, Integer age, String gender, String bloodGroup, String contactNumber, String email, String address, LocalDate lastDonationDate, String healthStatus) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.bloodGroup = bloodGroup;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.lastDonationDate = lastDonationDate;
        this.healthStatus = healthStatus;
    }

    public Long getDonorId() {
        return donorId;
    }

    public void setDonorId(Long donorId) {
        this.donorId = donorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getLastDonationDate() {
        return lastDonationDate;
    }

    public void setLastDonationDate(LocalDate lastDonationDate) {
        this.lastDonationDate = lastDonationDate;
    }

    public String getHealthStatus() {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus) {
        this.healthStatus = healthStatus;
    }

    // Eligibility Business Helpers
    public boolean isAgeEligible() {
        return age != null && age >= 18 && age <= 65;
    }

    public boolean isHealthFit() {
        return "Fit".equalsIgnoreCase(healthStatus) || "Healthy".equalsIgnoreCase(healthStatus) || "Eligible".equalsIgnoreCase(healthStatus);
    }

    public Long getDaysSinceLastDonation() {
        if (lastDonationDate == null) {
            return null;
        }
        return ChronoUnit.DAYS.between(lastDonationDate, LocalDate.now());
    }

    public boolean isIntervalEligible() {
        if (lastDonationDate == null) {
            return true; // First time donor
        }
        return getDaysSinceLastDonation() >= 90;
    }

    public boolean isFullyEligible() {
        return isAgeEligible() && isHealthFit() && isIntervalEligible();
    }

    public String getEligibilityReason() {
        if (!isAgeEligible()) {
            return "Age must be between 18 and 65 (current: " + age + ")";
        }
        if (!isHealthFit()) {
            return "Health status must be Fit (current: " + healthStatus + ")";
        }
        if (!isIntervalEligible()) {
            return "Last donation was only " + getDaysSinceLastDonation() + " days ago (minimum 90 days required)";
        }
        return "Eligible to donate blood";
    }

    @Override
    public String toString() {
        return "BloodDonor{" +
                "donorId=" + donorId +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", bloodGroup='" + bloodGroup + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", healthStatus='" + healthStatus + '\'' +
                '}';
    }
}

