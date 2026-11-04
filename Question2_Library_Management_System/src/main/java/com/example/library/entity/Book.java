package com.example.library.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "books")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_id")
    private Long bookId;

    @NotBlank(message = "Book title is required")
    @Size(min = 1, max = 200, message = "Title must be between 1 and 200 characters")
    @Column(name = "title", nullable = false)
    private String title;

    @NotBlank(message = "Author is required")
    @Column(name = "author", nullable = false)
    private String author;

    @NotBlank(message = "Publisher is required")
    @Column(name = "publisher", nullable = false)
    private String publisher;

    @NotBlank(message = "ISBN is required")
    @Column(name = "isbn", nullable = false, unique = true)
    private String isbn;

    @NotBlank(message = "Edition is required")
    @Column(name = "edition", nullable = false)
    private String edition;

    @NotNull(message = "Publication year is required")
    @Min(value = 1000, message = "Publication year must be valid")
    @Max(value = 2100, message = "Publication year cannot be in the distant future")
    @Column(name = "publication_year", nullable = false)
    private Integer publicationYear;

    @NotBlank(message = "Category is required")
    @Column(name = "category", nullable = false)
    private String category;

    @NotNull(message = "Available copies is required")
    @Min(value = 0, message = "Available copies cannot be negative")
    @Column(name = "available_copies", nullable = false)
    private Integer availableCopies;

    public Book() {
    }

    public Book(String title, String author, String publisher, String isbn, String edition, Integer publicationYear, String category, Integer availableCopies) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.isbn = isbn;
        this.edition = edition;
        this.publicationYear = publicationYear;
        this.category = category;
        this.availableCopies = availableCopies;
    }

    public Long getBookId() {
        return bookId;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public Integer getPublicationYear() {
        return publicationYear;
    }

    public void setPublicationYear(Integer publicationYear) {
        this.publicationYear = publicationYear;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getAvailableCopies() {
        return availableCopies;
    }

    public void setAvailableCopies(Integer availableCopies) {
        this.availableCopies = availableCopies;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookId=" + bookId +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", publisher='" + publisher + '\'' +
                ", isbn='" + isbn + '\'' +
                ", edition='" + edition + '\'' +
                ", publicationYear=" + publicationYear +
                ", category='" + category + '\'' +
                ", availableCopies=" + availableCopies +
                '}';
    }
}

