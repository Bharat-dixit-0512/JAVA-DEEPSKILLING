package com.library.repository;

import java.util.Arrays;
import java.util.List;

public class BookRepository {
    public List<String> getBooks() {
        return Arrays.asList("Spring Framework 5", "Pro Spring Boot 2", "Spring Security in Action");
    }
}
