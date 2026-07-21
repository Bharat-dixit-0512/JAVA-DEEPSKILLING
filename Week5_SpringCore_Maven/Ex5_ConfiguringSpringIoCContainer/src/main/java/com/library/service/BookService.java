package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {
    private BookRepository bookRepository;

    // Setter for IoC container to inject dependency
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("[BookService] BookRepository injected via IoC container setter.");
    }

    public void listBooks() {
        System.out.println("[BookService] Listing books from IoC managed repository:");
        List<String> books = bookRepository.getBooks();
        for (String book : books) {
            System.out.println("  * " + book);
        }
    }
}
