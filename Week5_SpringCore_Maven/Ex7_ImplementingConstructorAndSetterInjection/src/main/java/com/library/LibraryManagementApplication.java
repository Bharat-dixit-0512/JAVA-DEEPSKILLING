package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LibraryManagementApplication {
    public static void main(String[] args) {
        System.out.println("=== Exercise 7: Constructor and Setter Injection ===");
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        System.out.println("\n--- Testing Constructor Injection ---");
        BookService constructorService = (BookService) context.getBean("bookServiceConstructor");
        constructorService.listBooks();

        System.out.println("\n--- Testing Setter Injection ---");
        BookService setterService = (BookService) context.getBean("bookServiceSetter");
        setterService.listBooks();

        System.out.println("\n=== Both injection types verified successfully ===");
    }
}
