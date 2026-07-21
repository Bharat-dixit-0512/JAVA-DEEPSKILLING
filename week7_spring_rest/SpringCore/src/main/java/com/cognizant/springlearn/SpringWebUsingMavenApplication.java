package com.cognizant.springlearn;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringWebUsingMavenApplication {

    public static void main(String[] args) {

        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("date-format.xml");

        SimpleDateFormat dateFormat =
                context.getBean("dateFormat", SimpleDateFormat.class);

        Date date = new Date();

        System.out.println(dateFormat.format(date));

        context.close();
    }
}