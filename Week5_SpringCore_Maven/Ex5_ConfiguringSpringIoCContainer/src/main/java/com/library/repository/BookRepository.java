package com.library.repository;

import java.util.Arrays;
import java.util.List;

public class BookRepository {
    public List<String> getBooks() {
        return Arrays.asList("Domain-Driven Design", "Working Effectively with Legacy Code", "Test-Driven Development");
    }
}
