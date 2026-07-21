package com.library.service;

import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public void showBooks() {
        System.out.println("[BookService] @Service annotation detected by component scan.");
        System.out.println("[BookService] @Repository bean auto-wired: " + bookRepository.getClass().getSimpleName());
        List<String> books = bookRepository.getBooks();
        System.out.println("[BookService] Books: " + books);
    }
}
