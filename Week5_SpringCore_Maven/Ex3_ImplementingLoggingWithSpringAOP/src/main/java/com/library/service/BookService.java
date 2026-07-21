package com.library.service;

import com.library.repository.BookRepository;
import java.util.List;

public class BookService {
    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<String> getBooks() {
        System.out.println("[BookService] Fetching books...");
        return bookRepository.getBooks();
    }
}
