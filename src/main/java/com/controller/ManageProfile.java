package com.controller;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.DatabaseConnectivity;
import com.google.gson.Gson;

@WebServlet("/manageStudentDetails")
public class ManageProfile extends HttpServlet {
    private Gson gson = new Gson();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        DatabaseConnectivity DBConnection = new DatabaseConnectivity();
        List<Map<String, String>> students = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT admin_no, student_name AS name FROM students ORDER BY admin_no"; // Fixed: Added missing comma after 'name'
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("admin_no", rs.getString("admin_no"));
                student.put("name", rs.getString("name"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(students));
        out.flush();
    }
}