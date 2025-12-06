// StudentServlet.java (Final updated complete servlet code with all fixes: safe handling, debug logs, NumberFormatException catch, and "NA" defaults)
package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

import com.DAO.DatabaseConnectivity;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;

@WebServlet("/GetStudentProfile")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final StudentDetailsInter studentDetailsInter = new StudentDetailsImp();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        DatabaseConnectivity databaseConnectivity = new DatabaseConnectivity();
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

            // ✅ Validate studentId is numeric before query
            int studentIdInt;
            try {
                studentIdInt = Integer.parseInt(finalStudentId);
            } catch (NumberFormatException e) {
                result.put("error", "Invalid student ID format.");
                out.print(result.toString());
                return;
            }

            // ✅ Fetch student details (extend query if needed for additional fields like section, marks)
            try (Connection con = databaseConnectivity.getConnection()) {
                String sql = "SELECT * FROM students WHERE student_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, studentIdInt);
                ResultSet rs = ps.executeQuery();

                // Debug logging (check server logs)

                if (rs.next()) {
                    // Helper method to safely get string value, replacing null/empty with "NA"
                    // Wrapped in try-catch to handle potential SQLException (e.g., column not found due to schema changes)
                    java.util.function.Function<String, String> safeGetString = fieldName -> {
                        try {
                            String val = rs.getString(fieldName);
                            return (val == null || val.trim().isEmpty()) ? "NA" : val.trim();
                        } catch (SQLException e) {
                            // Log the error if needed (e.g., via logger), but return "NA" to avoid breaking the whole response
                            System.out.println("Error fetching field '" + fieldName + "': " + e.getMessage());
                            return "NA";
                        }
                    };

                    // For student_id, use getInt with safe handling (since it's numeric, but store as string for consistency/JSON)
                    try {
                        int sid = rs.getInt("student_id");
                        result.put("student_id", (rs.wasNull() ? "NA" : String.valueOf(sid)));
                    } catch (SQLException e) {
                        System.out.println("Error fetching student_id: " + e.getMessage());
                        result.put("student_id", "NA");
                    }

                    result.put("admin_no", safeGetString.apply("admin_no"));
                    result.put("student_name", safeGetString.apply("student_name"));
                    result.put("email", safeGetString.apply("email"));
                    result.put("class1", safeGetString.apply("class")); // Use "class1" key in JS as data.class1
                    result.put("father_name", safeGetString.apply("father_name"));
                    result.put("father_number", safeGetString.apply("father_number"));
                    result.put("mother_name", safeGetString.apply("mother_name"));
                    result.put("mother_number", safeGetString.apply("mother_number"));
                    result.put("guardian_name", safeGetString.apply("guardian_name"));
                    result.put("guardian_number", safeGetString.apply("guardian_number"));
                    result.put("address", safeGetString.apply("address"));
                    result.put("aadhar_number", safeGetString.apply("aadhar_number"));

                    // For numeric fields (total_fee, paid_fee, age), safe handling with "NA" for null/invalid
                    try {
                        double totalFee = rs.getDouble("total_fee");
                        result.put("total_fee", (rs.wasNull() ? "NA" : String.valueOf(totalFee)));
                    } catch (SQLException e) {
                        System.out.println("Error fetching total_fee: " + e.getMessage());
                        result.put("total_fee", "NA");
                    }

                    try {
                        double paidFee = rs.getDouble("paid_fee");
                        result.put("paid_fee", (rs.wasNull() ? "NA" : String.valueOf(paidFee)));
                    } catch (SQLException e) {
                        System.out.println("Error fetching paid_fee: " + e.getMessage());
                        result.put("paid_fee", "NA");
                    }

                    try {
                        int age = rs.getInt("age");
                        result.put("age", (rs.wasNull() ? "NA" : String.valueOf(age)));
                    } catch (SQLException e) {
                        System.out.println("Error fetching age: " + e.getMessage());
                        result.put("age", "NA");
                    }

                    result.put("gender", safeGetString.apply("gender"));
                    result.put("dob", safeGetString.apply("dob"));
                    result.put("pincode", safeGetString.apply("pincode"));
                    result.put("photo", safeGetString.apply("photo"));
                    // Add more fields if queried (e.g., JOIN with attendance/marks tables)
                    // Example: result.put("section", safeGetString.apply("section"));
                    // result.put("fullPhoto", safeGetString.apply("fullPhoto"));
                } else {
                    // Debug logging (check server logs)
                    System.out.println("No student row found for student_id: " + studentIdInt);
                    result.put("error", "Student not found.");
                }
            }
            // System.out.println(result);
            out.print(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Unexpected error in StudentServlet: " + e.getMessage());
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