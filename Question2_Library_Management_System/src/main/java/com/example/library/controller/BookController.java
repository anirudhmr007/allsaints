package com.example.library.controller;

import com.example.library.entity.Book;
import com.example.library.service.BookService;
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
@RequestMapping({"/", "/books"})
public class BookController {

    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    // Display all available books in a JSP table
    @GetMapping({"", "/list"})
    public String listBooks(Model model) {
        List<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        return "book-list";
    }

    // Show form to add a new book
    @GetMapping("/new")
    public String showAddBookForm(Model model) {
        if (!model.containsAttribute("book")) {
            model.addAttribute("book", new Book());
        }
        model.addAttribute("isEdit", false);
        return "book-form";
    }

    // Add a new book and save the details in PostgreSQL
    @PostMapping("/new")
    public String saveBook(@Valid @ModelAttribute("book") Book book,
                           BindingResult result,
                           RedirectAttributes redirectAttributes,
                           Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "book-form";
        }
        try {
            bookService.saveBook(book);
            redirectAttributes.addFlashAttribute("successMessage", "Book '" + book.getTitle() + "' added successfully with ID: " + book.getBookId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving book: " + e.getMessage());
            return "redirect:/books/new";
        }
        return "redirect:/books/list";
    }

    // Search for a book using Book ID
    @GetMapping("/search")
    public String searchBook(@RequestParam(value = "bookId", required = false) Long bookId,
                             Model model) {
        if (bookId == null) {
            return "redirect:/books/list";
        }

        Optional<Book> bookOpt = bookService.getBookById(bookId);
        List<Book> searchResults = new ArrayList<>();
        if (bookOpt.isPresent()) {
            searchResults.add(bookOpt.get());
            model.addAttribute("searchSuccess", "Found book with ID: " + bookId);
        } else {
            model.addAttribute("searchError", "No book found with Book ID: " + bookId);
        }
        model.addAttribute("books", searchResults);
        model.addAttribute("searchedId", bookId);
        return "book-list";
    }

    // View detailed book information
    @GetMapping("/view/{id}")
    public String viewBook(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Book> bookOpt = bookService.getBookById(id);
        if (bookOpt.isPresent()) {
            model.addAttribute("book", bookOpt.get());
            return "book-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Book not found with ID: " + id);
        return "redirect:/books/list";
    }

    // Show edit book form
    @GetMapping("/edit/{id}")
    public String showEditBookForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Book> bookOpt = bookService.getBookById(id);
        if (bookOpt.isPresent()) {
            model.addAttribute("book", bookOpt.get());
            model.addAttribute("isEdit", true);
            return "book-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Book not found with ID: " + id);
        return "redirect:/books/list";
    }

    // Update book details
    @PostMapping("/update/{id}")
    public String updateBook(@PathVariable("id") Long id,
                             @Valid @ModelAttribute("book") Book book,
                             BindingResult result,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "book-form";
        }
        try {
            bookService.updateBook(id, book);
            redirectAttributes.addFlashAttribute("successMessage", "Book ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating book: " + e.getMessage());
        }
        return "redirect:/books/list";
    }

    // Delete a book record using Book ID
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = bookService.deleteBookById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Book with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Book with ID " + id + " not found.");
        }
        return "redirect:/books/list";
    }
}
