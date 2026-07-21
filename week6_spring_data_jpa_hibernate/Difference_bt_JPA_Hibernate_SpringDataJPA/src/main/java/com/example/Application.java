package com.example;

import com.example.entity.Student;
import com.example.service.JPAService;
import com.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application implements CommandLineRunner {

    @Autowired
    private StudentService studentService;

    @Autowired
    private JPAService jpaService;

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) {

        Student s1 = new Student("Avni", "CSE");
        studentService.saveStudent(s1);

        Student s2 = new Student("Rahul", "AI");
        jpaService.saveStudent(s2);
    }
}