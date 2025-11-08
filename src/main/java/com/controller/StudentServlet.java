package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/GetStudentProfile")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#"
        );
    }

    // ✅ Fetch full student details by student_id
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();

        try {
            String idStr = request.getParameter("studentId");
            if (idStr == null || idStr.trim().isEmpty()) {
                result.put("error", "Missing studentId parameter");
                out.print(result.toString());
                return;
            }

            try (Connection con = getConnection()) {
                String sql = "SELECT * FROM students WHERE student_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(idStr));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    result.put("student_id", rs.getInt("student_id"));
                    result.put("admin_no", rs.getString("admin_no"));
                    result.put("student_name", rs.getString("student_name"));
                    result.put("email", rs.getString("email"));
                    result.put("class1", rs.getString("class"));
                    result.put("father_name", rs.getString("father_name"));
                    result.put("father_number", rs.getString("father_number"));
                    result.put("mother_name", rs.getString("mother_name"));
                    result.put("mother_number", rs.getString("mother_number"));
                    result.put("guardian_name", rs.getString("guardian_name"));
                    result.put("guardian_number", rs.getString("guardian_number"));
                    result.put("address", rs.getString("address"));
                    result.put("aadhar_number", rs.getString("aadhar_number"));
                    result.put("total_fee", rs.getDouble("total_fee"));
                    result.put("paid_fee", rs.getDouble("paid_fee"));
                    result.put("gender", rs.getString("gender"));
                    result.put("age", rs.getInt("age"));
                    result.put("dob", rs.getString("dob"));
                    result.put("pincode", rs.getString("pincode"));
//                    result.put("photo", rs.getString("photo"));
//                    result.put("fullPhoto", rs.getString("fullPhoto"));
                } else {
                    result.put("error", "Student not found");
                }

                out.print(result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result.put("error", "Server error: " + e.getMessage());
            out.print(result.toString());
        }
    }
}
