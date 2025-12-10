package com.controller;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;
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
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

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
            // Optional: Validate date format
            try {
                DATE_FORMAT.parse(attendanceDate);
            } catch (ParseException e) {
                response.getWriter().write("ERROR: Invalid date format. Use YYYY-MM-DD.");
                return;
            }

            con = DatabaseConnectivity.getConnection();
            con.setAutoCommit(false); // Start transaction

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
                con.rollback(); // Clean up
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
                if (status == null || status.trim().isEmpty() || !("P".equals(status.trim()) || "A".equals(status.trim()) || "HD".equals(status.trim()))) continue;

                String reason = request.getParameter("reason_" + admin_no);
                String leaveType = null;
                if ("A".equals(status)) {
                    leaveType = request.getParameter("leave_type_" + admin_no);
                    if (leaveType != null && !leaveType.trim().isEmpty()) {
                        String trimmed = leaveType.trim();
                        // Expandable: Add more ENUM values here if schema changes (e.g., 'PERSONAL')
                        if (!("MEDICAL".equals(trimmed) || "OTHER".equals(trimmed))) {
                            leaveType = null; // Fallback to prevent truncation
                            System.err.println("Invalid leave_type '" + trimmed + "' for admin_no " + admin_no + "; set to NULL.");
                        } else {
                            leaveType = trimmed;
                        }
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
                        System.out.println("File uploaded: " + filePath); // Optional logging
                    }
                }

                // Add to batch
                insertStmt.setString(1, admin_no.trim());
                insertStmt.setString(2, attendanceDate);
                insertStmt.setString(3, status.trim());
                insertStmt.setString(4, leaveType);
                insertStmt.setString(5, reason != null ? reason.trim() : null);
                insertStmt.setString(6, filePath);
                insertStmt.addBatch();
                hasInserts = true;
            }

            if (hasInserts) {
                insertStmt.executeBatch();
                con.commit(); // Commit transaction
            } else {
                con.rollback(); // No data, rollback
                response.getWriter().write("ERROR: No valid attendance data to insert.");
                return;
            }

            response.getWriter().write("SUCCESS");
        } catch (SQLException e) {
            if (con != null)
				try {
					con.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}// Rollback on SQL error
            if (e.getMessage().contains("Data truncated for column 'leave_type'")) {
                System.err.println("ENUM validation failed for leave_type: " + e.getMessage());
                response.getWriter().write("ERROR: Invalid leave type. Use 'MEDICAL' or 'OTHER' only.");
            } else {
                e.printStackTrace();
                response.getWriter().write("ERROR: Database error - " + e.getMessage());
            }
        } catch (Exception e) {
            if (con != null)
				try {
					con.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} // Rollback on general error
            e.printStackTrace();
            response.getWriter().write("ERROR: " + e.getMessage());
        } finally {
            try { if (con != null) con.setAutoCommit(true); } catch (Exception ignore) {}
            try { if (classCheckStmt != null) classCheckStmt.close(); } catch (Exception ignore) {}
            try { if (insertStmt != null) insertStmt.close(); } catch (Exception ignore) {}
            try { if (con != null) con.close(); } catch (Exception ignore) {}
        }
    }
}