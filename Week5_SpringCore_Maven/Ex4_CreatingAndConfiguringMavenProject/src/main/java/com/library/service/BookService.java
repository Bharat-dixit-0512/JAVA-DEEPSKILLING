package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {
    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void showBooks() {
        System.out.println("[BookService] Maven project configured with Spring Context, AOP, and WebMVC.");
        List<String> books = bookRepository.getBooks();
        System.out.println("[BookService] Books: " + books);
    }
}
