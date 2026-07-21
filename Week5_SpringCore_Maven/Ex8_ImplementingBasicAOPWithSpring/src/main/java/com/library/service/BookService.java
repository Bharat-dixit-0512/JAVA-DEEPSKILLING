package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {
    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<String> getBooks() {
        System.out.println("[BookService] Retrieving books...");
        return bookRepository.getBooks();
    }

    public void addBook(String title) {
        System.out.println("[BookService] Adding book: " + title);
    }
}
