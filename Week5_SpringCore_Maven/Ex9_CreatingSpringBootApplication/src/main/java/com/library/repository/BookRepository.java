package com.library.repository;

import com.library.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Exercise 9: Spring Data JPA Repository for Book entity.
 * Extends JpaRepository to get CRUD operations out of the box.
 */
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}
