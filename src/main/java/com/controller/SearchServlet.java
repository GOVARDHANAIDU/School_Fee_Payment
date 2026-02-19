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
                "SELECT student_id, student_name, email, father_number, total_fee, paid_fee, " +
                "class, admin_no FROM students"
            );
            
//            student_id, admin_no, student_name, father_name, email, father_number, mother_name,
//            mother_number, guardian_name, guardian_number, address, class, aadhar_number, total_fee, 
//            gender, age, dob, pincode, paid_fee, photo, last_upload_by, last_upload_time

            while (rs.next()) {
                Map<String, String> student = new HashMap<>();

                student.put("student_id", rs.getString("student_id"));
                student.put("name", rs.getString("student_name"));
                student.put("email", rs.getString("email"));
                student.put("phone", rs.getString("father_number"));
                student.put("total_fee", rs.getString("total_fee"));
                student.put("paid_fee", rs.getString("paid_fee"));
                student.put("admissionnumber", rs.getString("admin_no"));
                student.put("class1", rs.getString("class"));

                double remaining = rs.getDouble("total_fee") - rs.getDouble("paid_fee");
                student.put("payingfee", String.valueOf(remaining));

                students.add(student);   // ✅ VERY IMPORTANT
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
