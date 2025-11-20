package com.controller;

import java.io.*;
import java.sql.*;
import java.util.UUID;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/UploadPhotoServlet")
@MultipartConfig
public class UploadPhotoServlet extends HttpServlet {
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

        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.isEmpty()) {
            out.write("Missing student ID");
            return;
        }

        // ✅ Get logged-in user (from session)
        HttpSession session = request.getSession(false);
        String uploadedBy = "Unknown";
        if (session != null) {
            if (session.getAttribute("adminName") != null)
                uploadedBy = session.getAttribute("adminName").toString();
            else if (session.getAttribute("email") != null)
                uploadedBy = session.getAttribute("email").toString();
        }

        String dbPath = null;
        // ✅ Image upload logic with DEBUG and safety checks
        try {
            System.out.println("=== UPLOAD DEBUG START ===");
            System.out.println("Content-Type: " + request.getContentType());
            if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart")) {
                System.out.println("Detected multipart request, attempting file upload...");
                try {
                    System.out.println("Parts count: " + request.getParts().size());
                    Part filePart = request.getPart("photo");
                    if (filePart != null && filePart.getSize() > 0) {
                        String submittedFileName = filePart.getSubmittedFileName();
                        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
                            System.out.println("Submitted file name is null or empty, skipping upload.");
                            out.write("❌ Invalid file name");
                            return;
                        }
                        System.out.println("File name: " + submittedFileName);
                        System.out.println("File size: " + filePart.getSize());

                        // Sanitize and generate unique filename (ensure extension)
                        String extension = submittedFileName.contains(".") ? submittedFileName.substring(submittedFileName.lastIndexOf(".")) : ".jpg";
                        String fileName = UUID.randomUUID().toString() + extension;
                        String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
                        System.out.println("Target upload dir: " + uploadDir);

                        File dir = new File(uploadDir);
                        System.out.println("Dir exists before mkdir: " + dir.exists());
                        if (!dir.exists()) {
                            boolean created = dir.mkdirs(); // Use mkdirs() for nested dirs
                            System.out.println("Dir created: " + created);
                            if (!created) {
                                System.out.println("Failed to create upload directory!");
                                out.write("❌ Failed to create upload directory");
                                return;
                            }
                        }

                        String fullPath = uploadDir + File.separator + fileName;
                        filePart.write(fullPath);

                        File uploadedFile = new File(fullPath);
                        System.out.println("File written? Exists: " + uploadedFile.exists() + ", Size: " + uploadedFile.length());
                        if (uploadedFile.exists() && uploadedFile.length() > 0) {
                            dbPath = "uploads/" + fileName;
                            System.out.println("DB path set: " + dbPath);
                        } else {
                            System.out.println("File write failed or empty!");
                            out.write("❌ File write failed");
                            return;
                        }
                    } else {
                        System.out.println("FilePart is null or empty!");
                    }
                } catch (Exception e) {
                    System.out.println("Multipart parse error: " + e.getMessage());
                    e.printStackTrace();
                    out.write("❌ Multipart parse error: " + e.getMessage());
                    return;
                }
            } else {
                System.out.println("Not multipart, skipping file upload.");
                out.write("❌ Request is not multipart/form-data");
                return;
            }
            System.out.println("=== UPLOAD DEBUG END ===");
        } catch (Exception e) {
            System.out.println("Upload exception: " + e.getMessage());
            e.printStackTrace();
            out.write("❌ Upload exception: " + e.getMessage());
            return;
        }

        // DB update only if file was successfully uploaded
        if (dbPath == null) {
            out.write("❌ No valid file to upload");
            return;
        }

        try (Connection con = getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE students SET photo=?, last_upload_by=?, last_upload_time=NOW() WHERE student_id=?"
            )) {
                ps.setString(1, dbPath);
                ps.setString(2, uploadedBy);
                ps.setInt(3, Integer.parseInt(studentId));

                int rows = ps.executeUpdate();

                if (rows > 0)
                    out.write("✅ Photo uploaded successfully");
                else
                    out.write("⚠️ Student not found");
            }
        } catch (Exception e) {
            System.out.println("DB update error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("❌ Database error: " + e.getMessage());
        }
    }
}