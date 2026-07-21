package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {
    private BookRepository bookRepository;

    // Setter method for dependency injection
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void displayBooks() {
        System.out.println("Displaying Books from Injected Repository:");
        List<String> books = bookRepository.getBooks();
        for (String book : books) {
            System.out.println(" - " + book);
        }
    }
}
