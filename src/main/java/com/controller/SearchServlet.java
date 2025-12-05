package com.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.DAO.DatabaseConnectivity;
import com.google.gson.Gson;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Map<String, String>> students = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DatabaseConnectivity.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(
                "SELECT student_id, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, " +
                "Student_Class, Admission_Number, Remaining_fee FROM studentfeedetails"
            );

            while (rs.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("student_id", rs.getString("student_id")); // ✅ added
                student.put("name", rs.getString("Student_Name"));
                student.put("email", rs.getString("Email_ID"));
                student.put("phone", rs.getString("Phone_Number"));
                student.put("total_fee", rs.getString("Total_Fee"));
                student.put("paid_fee", rs.getString("Paid_Fee"));
                student.put("admissionnumber", rs.getString("Admission_Number"));
                student.put("class1", rs.getString("Student_Class"));
                student.put("payingfee", rs.getString("Remaining_fee"));
                students.add(student);
            }
//            System.out.println("Hello "+students);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String json = new Gson().toJson(students);
        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}
