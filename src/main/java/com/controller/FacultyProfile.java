package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/GetFacultyProfile")
public class FacultyProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/school_data",
            "root",
            "W7301@jqir#"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();

        try {
            HttpSession session = request.getSession();

            // Parameters
            String facultyIdParam = request.getParameter("facultyId"); // primary DB key
            String facultyIDCodeParam = request.getParameter("facultyID"); // unique code (FAC001)
            String sessionFacultyID = (String) session.getAttribute("facultyID");

            String finalFacultyId = null;
            String finalFacultyCode = null;

            // Priority: param facultyId → param facultyID → session facultyID
            if (facultyIdParam != null && !facultyIdParam.trim().isEmpty()) {
                finalFacultyId = facultyIdParam;
            }
            else if (facultyIDCodeParam != null && !facultyIDCodeParam.trim().isEmpty()) {
                finalFacultyCode = facultyIDCodeParam;
            }
            else if (sessionFacultyID != null && !sessionFacultyID.trim().isEmpty()) {
                finalFacultyCode = sessionFacultyID;
            }

            // If facultyID code is provided, convert to internal numeric ID
            if (finalFacultyId == null && finalFacultyCode != null) {
                try (Connection con = getConnection()) {
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT id FROM faculty WHERE facultyID = ?"
                    );
                    ps.setString(1, finalFacultyCode);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        finalFacultyId = rs.getString("id");
                    } else {
                        result.put("error", "Invalid faculty identifier.");
                        out.print(result.toString());
                        return;
                    }
                }
            }

            // Final check
            if (finalFacultyId == null || finalFacultyId.isEmpty()) {
                result.put("error", "Missing valid faculty identifier.");
                out.print(result.toString());
                return;
            }

            // Fetch faculty details (exclude sensitive fields like password)
            try (Connection con = getConnection()) {
                String sql = "SELECT id, facultyID, name, email, phone_number, aadhar_number, gender, dob, " +
                             "qualification, department, designation, experience_years, join_date, salary, " +
                             "address, city, state, pincode, status, created_at, updated_at " +
                             "FROM faculty WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(finalFacultyId));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    result.put("id", rs.getInt("id"));
                    result.put("facultyID", rs.getString("facultyID"));
                    result.put("name", rs.getString("name"));
                    result.put("email", rs.getString("email"));
                    result.put("phone_number", rs.getString("phone_number"));
                    result.put("aadhar_number", rs.getString("aadhar_number"));
                    result.put("gender", rs.getString("gender"));
                    result.put("dob", rs.getString("dob"));
                    result.put("qualification", rs.getString("qualification"));
                    result.put("department", rs.getString("department"));
                    result.put("designation", rs.getString("designation"));
                    result.put("experience_years", rs.getString("experience_years"));
                    result.put("join_date", rs.getString("join_date"));
                    result.put("salary", rs.getString("salary"));
                    result.put("address", rs.getString("address"));
                    result.put("city", rs.getString("city"));
                    result.put("state", rs.getString("state"));
                    result.put("pincode", rs.getString("pincode"));
                    result.put("status", rs.getString("status"));
                    result.put("created_at", rs.getString("created_at"));
                    result.put("updated_at", rs.getString("updated_at"));
                } else {
                    result.put("error", "Faculty not found.");
                }
            }

            out.print(result.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("error", "Server error: " + e.getMessage());
            out.print(error.toString());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doPost(request, response);
    }
}