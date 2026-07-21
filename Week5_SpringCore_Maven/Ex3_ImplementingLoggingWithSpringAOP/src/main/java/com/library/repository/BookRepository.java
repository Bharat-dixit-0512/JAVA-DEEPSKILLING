package com.library.repository;

import java.util.Arrays;
import java.util.List;

public class BookRepository {
    public List<String> getBooks() {
        return Arrays.asList("Effective Java", "The Pragmatic Programmer", "Refactoring");
    }
}
