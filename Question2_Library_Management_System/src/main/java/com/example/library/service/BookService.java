package com.example.library.service;

import com.example.library.entity.Book;
import com.example.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service Layer: Business logic for Library Books.
 */
@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    // 1. Get all available books
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    // 2. Find book by Book ID
    public Book getBookById(Long id) {
        return bookRepository.findById(id).orElse(null);
    }

    // 3. Add or update book details
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

    // 4. Delete book by Book ID
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
}
