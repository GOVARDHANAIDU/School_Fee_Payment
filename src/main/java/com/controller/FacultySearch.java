package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/facultyServlet")
public class FacultySearch extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, String>> facultyList = new ArrayList<>();

        try {
            // MySQL Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#"
            );

            Statement stmt = conn.createStatement();

            // Correct SELECT Query for faculty table (excluding sensitive fields like password)
            ResultSet rs = stmt.executeQuery(
                "SELECT id, facultyID, name, email, phone_number, aadhar_number, gender, dob, " +
                "qualification, department, designation, experience_years, join_date, salary, " +
                "address, city, state, pincode, status, created_at, updated_at " +
                "FROM faculty"
            );

            while (rs.next()) {
                Map<String, String> faculty = new HashMap<>();

                faculty.put("id", rs.getString("id"));
                faculty.put("facultyID", rs.getString("facultyID"));
                faculty.put("name", rs.getString("name"));
                faculty.put("email", rs.getString("email"));
                faculty.put("phone_number", rs.getString("phone_number"));
                faculty.put("aadhar_number", rs.getString("aadhar_number"));
                faculty.put("gender", rs.getString("gender"));
                faculty.put("dob", rs.getString("dob"));
                faculty.put("qualification", rs.getString("qualification"));
                faculty.put("department", rs.getString("department"));
                faculty.put("designation", rs.getString("designation"));
                faculty.put("experience_years", rs.getString("experience_years"));
                faculty.put("join_date", rs.getString("join_date"));
                faculty.put("salary", rs.getString("salary"));
                faculty.put("address", rs.getString("address"));
                faculty.put("city", rs.getString("city"));
                faculty.put("state", rs.getString("state"));
                faculty.put("pincode", rs.getString("pincode"));
                faculty.put("status", rs.getString("status"));
                faculty.put("created_at", rs.getString("created_at"));
                faculty.put("updated_at", rs.getString("updated_at"));

                facultyList.add(faculty);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send JSON Response
        String json = new Gson().toJson(facultyList);
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}