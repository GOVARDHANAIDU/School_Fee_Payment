package com.controller;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;
import com.DTO.StudentDetails;

@WebServlet("/UpdateStudentProfile")
@MultipartConfig
public class UpdateStudentProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#"
        );
    }
    StudentDetailsInter studeDetailsInter = new StudentDetailsImp();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.isEmpty()) {
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

        String dbPath = null;

        // ✅ Image upload logic
        try {
            Part filePart = request.getPart("photo");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
                String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdir();

                filePart.write(uploadDir + File.separator + fileName);
                dbPath = "uploads/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try (Connection con = getConnection()) {
            StringBuilder sql = new StringBuilder(
                "UPDATE students SET student_name=?, email=?, father_name=?, father_number=?, mother_name=?, mother_number=?, guardian_name=?, guardian_number=?, address=?, aadhar_number=?, total_fee=?, paid_fee=?, gender=?, age=?, dob=?, pincode=?, last_upload_by=?, last_upload_time=NOW()"
            );

            if (dbPath != null) sql.append(", photo=?");
            sql.append(" WHERE student_id=?");

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int i = 1;

            ps.setString(i++, request.getParameter("studentName"));
            ps.setString(i++, request.getParameter("email"));
            ps.setString(i++, request.getParameter("fatherName"));
            ps.setString(i++, request.getParameter("fatherNumber"));
            ps.setString(i++, request.getParameter("motherName"));
            ps.setString(i++, request.getParameter("motherNumber"));
            ps.setString(i++, request.getParameter("guardianName"));
            ps.setString(i++, request.getParameter("guardianNumber"));
            ps.setString(i++, request.getParameter("address"));
            ps.setString(i++, request.getParameter("aadharNumber"));
            ps.setDouble(i++, Double.parseDouble(request.getParameter("totalFee")));
            ps.setDouble(i++, Double.parseDouble(request.getParameter("paidFee")));
            ps.setString(i++, request.getParameter("gender"));
            ps.setInt(i++, Integer.parseInt(request.getParameter("age")));
            ps.setString(i++, request.getParameter("dob"));
            ps.setString(i++, request.getParameter("pincode"));
            ps.setString(i++, updatedBy);
            
            if (dbPath != null) ps.setString(i++, dbPath);
            ps.setInt(i++, Integer.parseInt(studentId));
           
            int rows = ps.executeUpdate();
            StudentDetails studentDetails = new StudentDetails();
            List<StudentDetails> studentsFeeUpdatesList = new ArrayList<>();

//            Student_id, Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class
            studentDetails.setStudentId(Integer.parseInt(studentId));
            studentDetails.setStudentName(request.getParameter("studentName"));
            studentDetails.setEmailID(request.getParameter("email"));
            studentDetails.setPaidFee(Double.parseDouble(request.getParameter("paidFee")));
            studentDetails.setTotalFee(Double.parseDouble(request.getParameter("totalFee")));
            studentDetails.setPhoneNumber(Long.parseLong(request.getParameter("fatherNumber")));
            studentsFeeUpdatesList.add(studentDetails);
            
            studeDetailsInter.updateStudentFeeFromManageProfile(studentsFeeUpdatesList);
 
            if (rows > 0)
                out.write("✅ Profile updated successfully");
            else
                out.write("⚠️ Student not found");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("❌ Error updating: " + e.getMessage());
        }
    }
}