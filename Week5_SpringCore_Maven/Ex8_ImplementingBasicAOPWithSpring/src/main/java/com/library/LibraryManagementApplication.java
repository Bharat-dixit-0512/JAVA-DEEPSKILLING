package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 8: Implementing Basic AOP with Spring ===");
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService = (BookService) context.getBean("bookService");

        System.out.println("\n--- Calling getBooks() - @Before and @After advice will fire ---");
        System.out.println("Books: " + bookService.getBooks());

        System.out.println("\n--- Calling addBook() - @Before and @After advice will fire again ---");
        bookService.addBook("Introduction to AOP");

        System.out.println("\n=== AOP Advice (@Before, @After) verified ===");
    }
}
