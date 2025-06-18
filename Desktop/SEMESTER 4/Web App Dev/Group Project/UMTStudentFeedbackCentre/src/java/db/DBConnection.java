///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template

package db; // Package where this DB connection class is stored

import java.sql.*; // Importing SQL classes for database connection

public class DBConnection {
    
    // Method to get and return a database connection
    public static Connection getConnection() throws Exception {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection to local MySQL server running on port 3307
        // Database name: umt_student_feedback_center
        // Username: root
        // Password: (empty)
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/umt_student_feedback_center",
            "root",
            ""
        );
    }
}
//package db;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//
//public class DBConnection {
//
//    public static Connection getConnection() throws Exception {
//        Class.forName("com.mysql.cj.jdbc.Driver");
//        return DriverManager.getConnection(
//                "jdbc:mysql://application.megatechsolution.org:3306/umt_student_feedback_center",
//                "student",
//                "student_umt_2025"
//        );
//    }
//}
