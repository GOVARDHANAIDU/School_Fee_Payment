package com.controller;

import java.io.*;
import java.sql.*;
import java.util.UUID;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/UpdateFacultyProfile")
@MultipartConfig
public class UpdateFacultyProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#"
        );
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        String facultyId = request.getParameter("facultyId");  // Use 'facultyId' param from JS (internal ID)
        if (facultyId == null || facultyId.isEmpty()) {
            out.write("Missing faculty ID");
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
        // ✅ Image upload logic (for avatar/photo)
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
            // Build UPDATE query for faculty columns (exclude passwords, use relevant profile fields)
            StringBuilder sql = new StringBuilder(
                "UPDATE faculty SET name=?, email=?, phone_number=?, aadhar_number=?, gender=?, dob=?, " +
                "qualification=?, department=?, designation=?, experience_years=?, join_date=?, salary=?, " +
                "address=?, city=?, state=?, pincode=?, status=?, last_upload_by=?, last_upload_time=NOW()"
            );
            if (dbPath != null) sql.append(", photo=?");  // Assume 'photo' column exists; add if not
            sql.append(" WHERE id=?");  // Use internal 'id' for update

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int i = 1;
            ps.setString(i++, request.getParameter("name"));
            ps.setString(i++, request.getParameter("email"));
            ps.setString(i++, request.getParameter("phone_number"));
            ps.setString(i++, request.getParameter("aadhar_number"));
            ps.setString(i++, request.getParameter("gender"));
            ps.setString(i++, request.getParameter("dob"));
            ps.setString(i++, request.getParameter("qualification"));
            ps.setString(i++, request.getParameter("department"));
            ps.setString(i++, request.getParameter("designation"));
            ps.setString(i++, request.getParameter("experience_years"));
            ps.setString(i++, request.getParameter("join_date"));
            ps.setString(i++, request.getParameter("salary"));
            ps.setString(i++, request.getParameter("address"));
            ps.setString(i++, request.getParameter("city"));
            ps.setString(i++, request.getParameter("state"));
            ps.setString(i++, request.getParameter("pincode"));
            ps.setString(i++, request.getParameter("status"));
            ps.setString(i++, updatedBy);

            if (dbPath != null) ps.setString(i++, dbPath);

            ps.setInt(i++, Integer.parseInt(facultyId));  // Internal ID

            int rows = ps.executeUpdate();

            // Optional: DAO call for additional logic (e.g., salary log update, similar to student fee)
            // If no specific DAO needed for faculty, skip or implement as per your setup
           
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("❌ Error updating: " + e.getMessage());
        }
    }
}