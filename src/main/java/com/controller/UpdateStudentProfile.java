package com.controller;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.DAO.DatabaseConnectivity;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;
import com.DTO.StudentDetails;

@WebServlet("/UpdateStudentProfile")
public class UpdateStudentProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;
    StudentDetailsInter studeDetailsInter = new StudentDetailsImp();
    DatabaseConnectivity databaseConnectivity = new DatabaseConnectivity();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        try {
            String studentId = request.getParameter("studentId");
            if (studentId == null || studentId.trim().isEmpty()) {
                out.write("Missing student ID");
                return;
            }

            // ✅ Get logged-in user (from session)
            HttpSession session = request.getSession(false);
            String updatedBy = "Unknown";
            if (session != null) {
                if (session.getAttribute("adminName") != null)
                    updatedBy = session.getAttribute("adminName").toString();
                else if (session.getAttribute("email") != null)
                    updatedBy = session.getAttribute("email").toString();
            }

            // ✅ No photo handling here - decoupled to UploadPhotoServlet
            // Photo updates are handled separately via that servlet

            // ✅ Helper to safely get string param
            java.util.function.Function<String, String> safeGetParam = paramName -> {
                String val = request.getParameter(paramName);
                return (val == null || val.trim().isEmpty()) ? "" : val.trim();
            };

            // ✅ Collect all parameters safely
            String studentName = safeGetParam.apply("studentName");
            String email = safeGetParam.apply("email");
            String fatherName = safeGetParam.apply("fatherName");
            String fatherNumber = safeGetParam.apply("fatherNumber");
            String motherName = safeGetParam.apply("motherName");
            String motherNumber = safeGetParam.apply("motherNumber");
            String guardianName = safeGetParam.apply("guardianName");
            String guardianNumber = safeGetParam.apply("guardianNumber");
            String address = safeGetParam.apply("address");
            String aadharNumber = safeGetParam.apply("aadharNumber");
            String totalFeeStr = safeGetParam.apply("totalFee");
            String paidFeeStr = safeGetParam.apply("paidFee");
            String gender = safeGetParam.apply("gender");
            String ageStr = safeGetParam.apply("age");
            String dob = safeGetParam.apply("dob");
            String pincode = safeGetParam.apply("pincode");

            // ✅ Validate required fields
            if (studentName.isEmpty()) {
                out.write("Student name is required");
                return;
            }

            // ✅ Parse numerics safely with defaults
            double totalFee = 0.0;
            try {
                totalFee = Double.parseDouble(totalFeeStr.isEmpty() ? "0" : totalFeeStr);
            } catch (NumberFormatException e) {
                totalFee = 0.0;
            }

            double paidFee = 0.0;
            try {
                paidFee = Double.parseDouble(paidFeeStr.isEmpty() ? "0" : paidFeeStr);
            } catch (NumberFormatException e) {
                paidFee = 0.0;
            }

            int age = 0;
            try {
                age = Integer.parseInt(ageStr.isEmpty() ? "0" : ageStr);
            } catch (NumberFormatException e) {
                age = 0;
            }

            long phoneNumber = 0L;
            try {
                phoneNumber = Long.parseLong(fatherNumber.isEmpty() ? "0" : fatherNumber);
            } catch (NumberFormatException e) {
                phoneNumber = 0L;
            }

            try (Connection con = databaseConnectivity.getConnection()) {
                // ✅ Fixed SQL: Matched original structure (no admin_no, used last_upload_by to match DB)
                // Removed conditional photo
                String sql = "UPDATE students SET student_name=?, email=?, father_name=?, father_number=?, " +
                             "mother_name=?, mother_number=?, guardian_name=?, guardian_number=?, address=?, " +
                             "aadhar_number=?, total_fee=?, paid_fee=?, gender=?, age=?, dob=?, pincode=?, " +
                             "last_upload_by=?, last_upload_time=NOW() WHERE student_id=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    int i = 1;
                    ps.setString(i++, studentName);
                    ps.setString(i++, email);
                    ps.setString(i++, fatherName);
                    ps.setString(i++, fatherNumber);
                    ps.setString(i++, motherName);
                    ps.setString(i++, motherNumber);
                    ps.setString(i++, guardianName);
                    ps.setString(i++, guardianNumber);
                    ps.setString(i++, address);
                    ps.setString(i++, aadharNumber);
                    ps.setDouble(i++, totalFee);
                    ps.setDouble(i++, paidFee);
                    ps.setString(i++, gender);
                    ps.setInt(i++, age);
                    ps.setString(i++, dob);
                    ps.setString(i++, pincode);
                    ps.setString(i++, updatedBy); // Using existing last_upload_by column
                    ps.setInt(i++, Integer.parseInt(studentId));

                    int rows = ps.executeUpdate();

                    // ✅ Fee update via DAO (if needed - assuming it handles the list)
                    if (rows > 0) {
                        StudentDetails studentDetails = new StudentDetails();
                        List<StudentDetails> studentsFeeUpdatesList = new ArrayList<>();
                        studentDetails.setStudentId(Integer.parseInt(studentId));
                        studentDetails.setStudentName(studentName);
                        studentDetails.setEmailID(email);
                        studentDetails.setPaidFee(paidFee);
                        studentDetails.setTotalFee(totalFee);
                        studentDetails.setPhoneNumber(phoneNumber);
                        studentsFeeUpdatesList.add(studentDetails);
                        studeDetailsInter.updateStudentFeeFromManageProfile(studentsFeeUpdatesList);
                    }

                    if (rows > 0)
                        out.write("✅ Profile updated successfully");
                    else
                        out.write("⚠️ Student not found");
                }
            } catch (SQLException e) {
                System.out.println("DB update error: " + e.getMessage());
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("❌ Database error: " + e.getMessage());
            }
        } catch (Exception e) {
            System.out.println("Unexpected error in UpdateStudentProfile: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("❌ Error updating: " + e.getMessage());
        }
    }

    // Optional: Handle GET if needed
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}