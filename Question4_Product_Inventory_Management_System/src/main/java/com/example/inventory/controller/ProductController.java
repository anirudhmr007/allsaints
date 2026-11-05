package com.example.inventory.controller;

import com.example.inventory.entity.Product;
import com.example.inventory.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Product Inventory.
 */
@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    // 1. Display all registered products in a JSP table
    @GetMapping({"/", "/products", "/products/list"})
    public String showProductsList(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "product-list";
    }

    // 2. Show form to add a new product
    @GetMapping("/products/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("pageTitle", "Add New Product");
        return "product-form";
    }

    // 3. Save new product or update existing product
    @PostMapping("/products/save")
    public String saveProduct(@ModelAttribute("product") Product product, RedirectAttributes redirectAttributes) {
        productService.saveProduct(product);
        redirectAttributes.addFlashAttribute("message", "Product saved successfully!");
        return "redirect:/products";
    }

    // 4. Search for a product using Product ID
    @GetMapping("/products/search")
    public String searchProduct(@RequestParam(value = "productId", required = false) Long productId, Model model) {
        if (productId != null) {
            Product product = productService.getProductById(productId);
            List<Product> resultList = new ArrayList<>();
            if (product != null) {
                resultList.add(product);
            } else {
                model.addAttribute("error", "No product found with Product ID: " + productId);
            }
            model.addAttribute("products", resultList);
            model.addAttribute("searchedId", productId);
        } else {
            model.addAttribute("products", productService.getAllProducts());
        }
        return "product-list";
    }

    // 5. Show form to update product details
    @GetMapping("/products/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("pageTitle", "Update Product Details");
        return "product-form";
    }

    // 6. Delete a product record using Product ID
    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        productService.deleteProduct(id);
        redirectAttributes.addFlashAttribute("message", "Product deleted successfully!");
        return "redirect:/products";
    }
}
