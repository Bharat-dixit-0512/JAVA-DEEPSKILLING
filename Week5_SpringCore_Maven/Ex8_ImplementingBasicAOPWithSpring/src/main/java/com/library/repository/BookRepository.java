package com.library.repository;

import java.util.Arrays;
import java.util.List;

public class BookRepository {
    public List<String> getBooks() {
        return Arrays.asList("AOP in Action", "Spring AOP Programming", "Aspect-Oriented Software Development");
    }
}
