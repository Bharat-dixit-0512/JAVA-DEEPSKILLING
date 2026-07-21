package com.example.service;

import com.example.entity.Student;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
public class JPAService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void saveStudent(Student student) {

        entityManager.persist(student);

        System.out.println("Student saved using JPA EntityManager");
    }
}