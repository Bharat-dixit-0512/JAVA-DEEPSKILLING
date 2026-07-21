package com.example.service;

import com.example.entity.Student;
import com.example.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentRepository repository;

    public void saveStudent(Student student) {

        repository.save(student);

        System.out.println("Student saved using Spring Data JPA");
    }
}