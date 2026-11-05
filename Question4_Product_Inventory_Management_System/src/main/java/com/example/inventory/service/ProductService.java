package com.example.inventory.service;

import com.example.inventory.entity.Product;
import com.example.inventory.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service Layer: Business logic for Product Inventory operations.
 */
@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    // 1. Get all registered products
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // 2. Find product by Product ID
    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    // 3. Save or update product
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    // 4. Delete product by Product ID
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
}
