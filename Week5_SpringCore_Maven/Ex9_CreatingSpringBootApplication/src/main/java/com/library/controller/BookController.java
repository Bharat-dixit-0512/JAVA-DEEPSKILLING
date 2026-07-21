package com.library.controller;

import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

/**
 * Exercise 9: REST Controller to handle CRUD operations for Books.
 *
 * Endpoints:
 *   GET    /books          - Retrieve all books
 *   GET    /books/{id}     - Retrieve book by ID
 *   POST   /books          - Create a new book
 *   PUT    /books/{id}     - Update an existing book
 *   DELETE /books/{id}     - Delete a book
 */
@RestController
@RequestMapping("/books")
public class BookController {

    private final BookRepository bookRepository;

    @Autowired
    public BookController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    // GET /books
    @GetMapping
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    // GET /books/{id}
    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        Optional<Book> book = bookRepository.findById(id);
        return book.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // POST /books
    @PostMapping
    public ResponseEntity<Book> createBook(@RequestBody Book book) {
        Book saved = bookRepository.save(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }

    // PUT /books/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Long id, @RequestBody Book details) {
        return bookRepository.findById(id).map(existing -> {
            existing.setTitle(details.getTitle());
            existing.setAuthor(details.getAuthor());
            existing.setIsbn(details.getIsbn());
            existing.setPrice(details.getPrice());
            return ResponseEntity.ok(bookRepository.save(existing));
        }).orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // DELETE /books/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        if (bookRepository.existsById(id)) {
            bookRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }
}
