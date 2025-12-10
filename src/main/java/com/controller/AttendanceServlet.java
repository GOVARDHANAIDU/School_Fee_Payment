package com.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.DAO.DatabaseConnectivity;

@MultipartConfig
@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String attendanceDate = request.getParameter("date");
        String selectedClass = request.getParameter("selectedClass");
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        Connection con = null;
        PreparedStatement classCheckStmt = null;
        PreparedStatement insertStmt = null;
        try {
            if (attendanceDate == null || selectedClass == null || selectedClass.trim().isEmpty()) {
                response.getWriter().write("ERROR: Missing date or class parameter.");
                return;
            }

            con = DatabaseConnectivity.getConnection();

            // Check duplicate for entire class/date
            classCheckStmt = con.prepareStatement(
                "SELECT COUNT(*) FROM attendance a JOIN students s ON a.admin_no = s.admin_no " +
                "WHERE s.class = ? AND a.attendance_date = ?"
            );
            classCheckStmt.setString(1, selectedClass.trim());
            classCheckStmt.setString(2, attendanceDate);
            ResultSet classRs = classCheckStmt.executeQuery();
            if (classRs.next() && classRs.getInt(1) > 0) {
                classRs.close();
                response.getWriter().write("DUPLICATE");
                return;
            }
            classRs.close();

            // Insert query
            insertStmt = con.prepareStatement(
                "INSERT INTO attendance (admin_no, attendance_date, status, leave_type, reason, document_path) " +
                "VALUES (?, ?, ?, ?, ?, ?)"
            );

            boolean hasInserts = false;
            for (String key : request.getParameterMap().keySet()) {
                if (!key.startsWith("status_")) continue;
                String admin_no = key.replace("status_", "");
                if (admin_no == null || admin_no.trim().isEmpty()) continue;

                String status = request.getParameter(key);
                if (status == null || status.trim().isEmpty() || !("P".equals(status) || "A".equals(status) || "HD".equals(status))) continue;

                String reason = request.getParameter("reason_" + admin_no);
                String leaveType = null;
                if ("A".equals(status)) {
                    leaveType = request.getParameter("leave_type_" + admin_no);
                    // Validate ENUM-like: only 'MEDICAL' or 'OTHER' (ignore invalid to prevent truncation)
                    if (leaveType != null && !("MEDICAL".equals(leaveType.trim()) || "OTHER".equals(leaveType.trim()))) {
                        leaveType = null; // Fallback to NULL for invalid
                    } else {
                        leaveType = leaveType != null ? leaveType.trim() : null;
                    }
                }

                // Handle file upload
                String filePath = null;
                Part filePart = request.getPart("document_" + admin_no);
                if (filePart != null && filePart.getSize() > 0) {
                    String originalFileName = filePart.getSubmittedFileName();
                    if (originalFileName != null && !originalFileName.trim().isEmpty()) {
                        String fileName = admin_no + "_" + System.currentTimeMillis() + "_" + originalFileName;
                        String uploadDir = request.getServletContext().getRealPath("/") + "attendance_docs";
                        File dir = new File(uploadDir);
                        if (!dir.exists()) {
                            if (!dir.mkdirs()) {
                                throw new IOException("Failed to create upload directory: " + uploadDir);
                            }
                        }
                        filePath = "attendance_docs/" + fileName;
                        filePart.write(uploadDir + File.separator + fileName);
                    }
                }

                // Insert
                insertStmt.setString(1, admin_no.trim());
                insertStmt.setString(2, attendanceDate);
                insertStmt.setString(3, status.trim());
                insertStmt.setString(4, leaveType); // NULL for P/HD, or valid ENUM for A
                insertStmt.setString(5, reason != null ? reason.trim() : null);
                insertStmt.setString(6, filePath);
                insertStmt.addBatch();
                hasInserts = true;
            }

            if (hasInserts) {
                insertStmt.executeBatch();
            }

            response.getWriter().write("SUCCESS");
        } catch (SQLException e) {
            // Specific handling for truncation (ENUM invalid value)
            if (e.getMessage().contains("Data truncated for column 'leave_type'")) {
                System.err.println("ENUM validation failed for leave_type: " + e.getMessage());
                response.getWriter().write("ERROR: Invalid leave type. Use 'MEDICAL' or 'OTHER' only.");
            } else {
                e.printStackTrace();
                response.getWriter().write("ERROR: Database error - " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR: " + e.getMessage());
        } finally {
            try { if (classCheckStmt != null) classCheckStmt.close(); } catch (Exception ignore) {}
            try { if (insertStmt != null) insertStmt.close(); } catch (Exception ignore) {}
            try { if (con != null) con.close(); } catch (Exception ignore) {}
        }
    }
}