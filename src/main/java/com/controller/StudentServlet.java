// StudentServlet.java (Updated complete servlet code)
package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;

@WebServlet("/GetStudentProfile")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#"
        );
    }

    private final StudentDetailsInter studentDetailsInter = new StudentDetailsImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("application/json");
        JSONObject result = new JSONObject();
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String sessionAdmissionNo = (String) session.getAttribute("admissionNo");
            String studentIdParam = request.getParameter("studentId");
            String admissionNoParam = request.getParameter("admissionNo");
            String finalAdmissionNo = null;
            String finalStudentId = null;

            // ✅ Determine which identifier to use (priority: param studentId > param admissionNo > session admissionNo)
            if (studentIdParam != null && !studentIdParam.trim().isEmpty() && !studentIdParam.equalsIgnoreCase("null")) {
                finalStudentId = studentIdParam;
            } else if (admissionNoParam != null && !admissionNoParam.trim().isEmpty() && !admissionNoParam.equalsIgnoreCase("null")) {
                finalAdmissionNo = admissionNoParam;
            } else if (sessionAdmissionNo != null && !sessionAdmissionNo.trim().isEmpty()) {
                finalAdmissionNo = sessionAdmissionNo;
            }

            // ✅ If we only have admissionNo (from param or session), get studentId from DAO
            if (finalStudentId == null && finalAdmissionNo != null) {
                int tempId = studentDetailsInter.getStudentId(finalAdmissionNo);
                if (tempId > 0) {
                    finalStudentId = String.valueOf(tempId);
                } else {
                    result.put("error", "Invalid admission number.");
                    out.print(result.toString());
                    return;
                }
            }

            // ✅ If still null, respond with error
            if (finalStudentId == null || finalStudentId.trim().isEmpty()) {
                result.put("error", "Missing valid student identifier.");
                out.print(result.toString());
                return;
            }

            // ✅ Fetch student details (extend query if needed for additional fields like section, marks)
            try (Connection con = getConnection()) {
                String sql = "SELECT * FROM students WHERE student_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(finalStudentId));
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    result.put("student_id", rs.getInt("student_id"));
                    result.put("admin_no", rs.getString("admin_no"));
                    result.put("student_name", rs.getString("student_name"));
                    result.put("email", rs.getString("email"));
                    result.put("class1", rs.getString("class")); // Use "class1" key in JS as data.class1
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
                    result.put("photo", rs.getString("photo"));
                    // Add more fields if queried (e.g., JOIN with attendance/marks tables)
                    // Example: result.put("section", rs.getString("section"));
                    // result.put("fullPhoto", rs.getString("fullPhoto"));
                } else {
                    result.put("error", "Student not found.");
                }
            }
//            System.out.println(result);
            out.print(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", "Server error: " + e.getMessage());
            out.print(error.toString());
        }
    }

    // Optional: Handle GET if needed, but POST is used
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doPost(request, response); // Delegate to POST for simplicity
    }
}