package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {

    private BookRepository bookRepository;
    private String serviceName;

    // Constructor Injection
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        this.serviceName = "ConstructorService";
        System.out.println("[BookService] Constructor Injection: BookRepository injected via constructor.");
    }

    // Overloaded constructor to accept a name (used for setter-based bean)
    public BookService(String serviceName) {
        this.serviceName = serviceName;
        System.out.println("[BookService] Constructor Injection (name): " + serviceName);
    }

    // Setter Injection
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("[BookService] Setter Injection: BookRepository injected via setter.");
    }

    public void listBooks() {
        System.out.println("[" + serviceName + "] Listing books:");
        List<String> books = bookRepository.getBooks();
        for (String book : books) {
            System.out.println("   -> " + book);
        }
    }
}
