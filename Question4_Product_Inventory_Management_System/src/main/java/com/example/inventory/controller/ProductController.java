package com.example.inventory.controller;

import com.example.inventory.entity.Product;
import com.example.inventory.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping({"/", "/products"})
public class ProductController {

    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // Display all registered products in a JSP table
    @GetMapping({"", "/list"})
    public String listProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "product-list";
    }

    // Show form to add a new product
    @GetMapping("/new")
    public String showAddProductForm(Model model) {
        if (!model.containsAttribute("product")) {
            model.addAttribute("product", new Product());
        }
        model.addAttribute("isEdit", false);
        return "product-form";
    }

    // Add a new product and save details in PostgreSQL
    @PostMapping("/new")
    public String addProduct(@Valid @ModelAttribute("product") Product product,
                             BindingResult result,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "product-form";
        }
        try {
            productService.saveProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Product '" + product.getProductName() + "' registered successfully with ID: " + product.getProductId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error registering product: " + e.getMessage());
            return "redirect:/products/new";
        }
        return "redirect:/products/list";
    }

    // Search for a product using Product ID
    @GetMapping("/search")
    public String searchProduct(@RequestParam(value = "productId", required = false) Long productId,
                                Model model) {
        if (productId == null) {
            return "redirect:/products/list";
        }

        Optional<Product> productOpt = productService.getProductById(productId);
        List<Product> searchResults = new ArrayList<>();
        if (productOpt.isPresent()) {
            searchResults.add(productOpt.get());
            model.addAttribute("searchSuccess", "Found product with ID: " + productId);
        } else {
            model.addAttribute("searchError", "No product found with Product ID: " + productId);
        }
        model.addAttribute("products", searchResults);
        model.addAttribute("searchedId", productId);
        return "product-list";
    }

    // View detailed product information
    @GetMapping("/view/{id}")
    public String viewProduct(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            return "product-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Product not found with ID: " + id);
        return "redirect:/products/list";
    }

    // Show edit product form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            model.addAttribute("isEdit", true);
            return "product-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Product not found with ID: " + id);
        return "redirect:/products/list";
    }

    // Update product details
    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable("id") Long id,
                                @Valid @ModelAttribute("product") Product product,
                                BindingResult result,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "product-form";
        }
        try {
            productService.updateProduct(id, product);
            redirectAttributes.addFlashAttribute("successMessage", "Product ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating product: " + e.getMessage());
        }
        return "redirect:/products/list";
    }

    // Delete a product record using Product ID
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = productService.deleteProductById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Product record with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Product with ID " + id + " does not exist.");
        }
        return "redirect:/products/list";
    }
}

