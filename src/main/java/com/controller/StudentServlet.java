package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;
import com.DAO.DatabaseConnectivity;

@WebServlet("/GetStudentProfile")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try (PrintWriter out = response.getWriter()) {

            /* ================= SESSION CHECK ================= */
            HttpSession session = request.getSession(false);
            if (session == null) {
                result.put("success", false);
                result.put("error", "Session expired. Please login again.");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print(result.toString());
                return;
            }

            String role = (String) session.getAttribute("Roles");
            String sessionAdmissionNo = (String) session.getAttribute("admissionNo");
            String paramAdmissionNo = request.getParameter("admissionNo");

            /* ================= ADMISSION NO DECISION ================= */
            String finalAdmissionNo = null;

            if (paramAdmissionNo != null && !paramAdmissionNo.trim().isEmpty()
                    && !"null".equalsIgnoreCase(paramAdmissionNo)) {
                finalAdmissionNo = paramAdmissionNo.trim();
            } else if ("student".equalsIgnoreCase(role) && sessionAdmissionNo != null) {
                finalAdmissionNo = sessionAdmissionNo.trim();
            }

            if (finalAdmissionNo == null || finalAdmissionNo.isEmpty()) {
                result.put("success", false);
                result.put("error", "No student identifier provided.");
                out.print(result.toString());
                return;
            }

            /* ================= DATABASE ================= */
            try (Connection con = DatabaseConnectivity.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                         "SELECT * FROM students WHERE admin_no = ?")) {

                ps.setString(1, finalAdmissionNo);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        result.put("success", false);
                        result.put("error", "No student found with admission number: " + finalAdmissionNo);
                        out.print(result.toString());
                        return;
                    }

                    /* ================= RESULT BUILD ================= */
                    result.put("success", true);
                    result.put("message", "Student profile retrieved successfully");
                    result.put("role", role);

                    result.put("student_id", rs.getInt("student_id"));

                    result.put("admin_no", safeGetString(rs, "admin_no"));
                    result.put("student_name", safeGetString(rs, "student_name"));
                    result.put("email", safeGetString(rs, "email"));
                    result.put("class", safeGetString(rs, "class"));
                    result.put("gender", safeGetString(rs, "gender"));
                    result.put("dob", safeGetString(rs, "dob"));

                    int age = rs.getInt("age");
                    result.put("age", rs.wasNull() ? "NA" : age);

                    result.put("father_name", safeGetString(rs, "father_name"));
                    result.put("father_number", safeGetString(rs, "father_number"));
                    result.put("mother_name", safeGetString(rs, "mother_name"));
                    result.put("mother_number", safeGetString(rs, "mother_number"));
                    result.put("guardian_name", safeGetString(rs, "guardian_name"));
                    result.put("guardian_number", safeGetString(rs, "guardian_number"));
                    result.put("address", safeGetString(rs, "address"));
                    result.put("pincode", safeGetString(rs, "pincode"));
                    result.put("aadhar_number", safeGetString(rs, "aadhar_number"));

                    double totalFee = rs.getDouble("total_fee");
                    result.put("total_fee", rs.wasNull() ? "NA" : totalFee);

                    double paidFee = rs.getDouble("paid_fee");
                    result.put("paid_fee", rs.wasNull() ? "NA" : paidFee);

                    result.put("photo", safeGetString(rs, "photo"));
                }
            }

            out.print(result.toString());
            out.flush();

        } catch (SQLException e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Server error: " + e.getMessage());
        }
    }

    /* ================= HELPER METHOD ================= */
    private String safeGetString(ResultSet rs, String fieldName) {
        try {
            String val = rs.getString(fieldName);
            return (val == null || val.trim().isEmpty()) ? "NA" : val.trim();
        } catch (SQLException e) {
            System.out.println("Warning: Column not found: " + fieldName);
            return "NA";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doPost(request, response);
    }
}
