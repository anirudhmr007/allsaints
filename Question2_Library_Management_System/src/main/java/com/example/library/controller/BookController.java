package com.example.library.controller;

import com.example.library.entity.Book;
import com.example.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller Layer: Handles web requests for Library Management System.
 */
@Controller
public class BookController {

    @Autowired
    private BookService bookService;

    // 1. Display all available books in a JSP table
    @GetMapping({"/", "/books", "/books/list"})
    public String showBooksList(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
        return "book-list";
    }

    // 2. Show form to add a new book
    @GetMapping("/books/add")
    public String showAddBookForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("pageTitle", "Add New Book");
        return "book-form";
    }

    // 3. Save new book or update existing book
    @PostMapping("/books/save")
    public String saveBook(@ModelAttribute("book") Book book, RedirectAttributes redirectAttributes) {
        bookService.saveBook(book);
        redirectAttributes.addFlashAttribute("message", "Book saved successfully!");
        return "redirect:/books";
    }

    // 4. Search for a book using Book ID
    @GetMapping("/books/search")
    public String searchBook(@RequestParam(value = "bookId", required = false) Long bookId, Model model) {
        if (bookId != null) {
            Book book = bookService.getBookById(bookId);
            List<Book> resultList = new ArrayList<>();
            if (book != null) {
                resultList.add(book);
            } else {
                model.addAttribute("error", "No book found with Book ID: " + bookId);
            }
            model.addAttribute("books", resultList);
            model.addAttribute("searchedId", bookId);
        } else {
            model.addAttribute("books", bookService.getAllBooks());
        }
        return "book-list";
    }

    // 5. Show form to update book details
    @GetMapping("/books/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);
        model.addAttribute("pageTitle", "Update Book Details");
        return "book-form";
    }

    // 6. Delete a book record using Book ID
    @GetMapping("/books/delete/{id}")
    public String deleteBook(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        bookService.deleteBook(id);
        redirectAttributes.addFlashAttribute("message", "Book deleted successfully!");
        return "redirect:/books";
    }
}
