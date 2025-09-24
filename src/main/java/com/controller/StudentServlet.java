package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/schooldb", "root", "password");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONArray arr = new JSONArray();
        try (Connection con = getConnection()) {
            String sql = "SELECT s.student_id, s.admission_no, s.student_name, s.father_name, s.email, s.father_number, s.mother_name, s.mother_number, s.guardian_name, s.guardian_number, s.address, s.class, s.aadhar_number, s.total_fee, s.gender, s.age, s.dob, s.pincode, s.paid_fee, MAX(p.payment_date) as last_paid FROM students s LEFT JOIN payments p ON s.student_id = p.student_id GROUP BY s.student_id";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("student_id", rs.getInt("student_id"));
                obj.put("admission_no", rs.getString("admission_no"));
                obj.put("student_name", rs.getString("student_name"));
                obj.put("father_name", rs.getString("father_name"));
                obj.put("email", rs.getString("email"));
                obj.put("father_number", rs.getString("father_number"));
                obj.put("mother_name", rs.getString("mother_name"));
                obj.put("mother_number", rs.getString("mother_number"));
                obj.put("guardian_name", rs.getString("guardian_name"));
                obj.put("guardian_number", rs.getString("guardian_number"));
                obj.put("address", rs.getString("address"));
                obj.put("class", rs.getString("class"));
                obj.put("aadhar_number", rs.getString("aadhar_number"));
                obj.put("total_fee", rs.getDouble("total_fee"));
                obj.put("gender", rs.getString("gender"));
                obj.put("age", rs.getInt("age"));
                obj.put("dob", rs.getString("dob"));
                obj.put("pincode", rs.getString("pincode"));
                obj.put("paid_fee", rs.getDouble("paid_fee"));
                obj.put("last_paid", rs.getTimestamp("last_paid") != null ? rs.getTimestamp("last_paid").toString() : null);
                obj.put("photoUrl", ""); // Placeholder
                obj.put("avatarUrl", ""); // Placeholder
                arr.put(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print(new JSONArray().put(new JSONObject().put("error", "Database error: " + e.getMessage())).toString());
            return;
        }
        out.print(arr.toString());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().write("Method not allowed");
    }
}