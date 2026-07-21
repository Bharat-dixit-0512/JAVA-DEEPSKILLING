package com.library;

import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

/**
 * Exercise 9: Spring Boot Main Application.
 * Starts the embedded Tomcat server with auto-configuration.
 */
@SpringBootApplication
public class LibraryManagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(LibraryManagementApplication.class, args);
    }

    /**
     * Seeds the H2 in-memory database with sample books on startup.
     */
    @Bean
    public CommandLineRunner loadData(BookRepository bookRepository) {
        return args -> {
            bookRepository.save(new Book("Clean Code", "Robert C. Martin", "978-0132350884", 45.00));
            bookRepository.save(new Book("Effective Java", "Joshua Bloch", "978-0134685991", 50.00));
            bookRepository.save(new Book("Spring in Action", "Craig Walls", "978-1617294945", 40.00));
            bookRepository.save(new Book("Design Patterns (GoF)", "Gang of Four", "978-0201633610", 55.00));

            System.out.println("\n=================================================");
            System.out.println(" Spring Boot Library Management App Started!     ");
            System.out.println(" REST API : http://localhost:8080/books           ");
            System.out.println(" H2 Console: http://localhost:8080/h2-console     ");
            System.out.println("=================================================\n");
            System.out.println("Seeded Books:");
            bookRepository.findAll().forEach(book -> System.out.println("  -> " + book));
        };
    }
}
