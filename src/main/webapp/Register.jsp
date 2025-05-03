<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.math.BigDecimal" %>

<%
    // 1. Retrieve form data
    String adminNo = request.getParameter("adminNo");
    String studentName = request.getParameter("studentName");
    String fatherName = request.getParameter("fatherName");
    String email = request.getParameter("email");
    String fatherNumber = request.getParameter("mobileNumber");
    String motherName = request.getParameter("motherName");
    String motherNumber = request.getParameter("motherNumber");
    String guardian = request.getParameter("guardian");
    String guardianNumber = request.getParameter("guardianNumber");
    String address = request.getParameter("address");
    String className = request.getParameter("class");
    String aadharNumber = request.getParameter("aadharNumber");
    String totalFee = request.getParameter("totalFee");
    String gender = request.getParameter("gender");
    String age = request.getParameter("age");
    String dob = request.getParameter("dob");
    String pincode = request.getParameter("pincode");

    // 2. Basic server-side validation
    if (adminNo == null || adminNo.trim().isEmpty() || studentName == null || studentName.trim().isEmpty()
        || fatherName == null || email == null || totalFee == null || dob == null || age == null) {
        out.println("<h3 style='color:red;'>Please fill in all the required fields!</h3>");
        return;
    }

    // 3. Validate number fields
    BigDecimal feeAmount = null;
    int studentAge = 0;
    java.sql.Date dobDate = null;

    try {
        feeAmount = new BigDecimal(totalFee);
    } catch (NumberFormatException e) {
        out.println("<h3 style='color:red;'>Invalid total fee amount!</h3>");
        return;
    }

    try {
        studentAge = Integer.parseInt(age);
    } catch (NumberFormatException e) {
        out.println("<h3 style='color:red;'>Invalid age format!</h3>");
        return;
    }

    try {
        dobDate = java.sql.Date.valueOf(dob); // Must be yyyy-MM-dd
    } catch (IllegalArgumentException e) {
        out.println("<h3 style='color:red;'>Invalid Date of Birth format (use YYYY-MM-DD)!</h3>");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // 4. Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 5. Connect to database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_db", "root", "1234");

        // 6. Prepare SQL insert statement
        String sql = "INSERT INTO students (admin_no, student_name, father_name, email, father_number, mother_name, mother_number, guardian_name, guardian_number, address, class, aadhar_number, total_fee, gender, age, dob, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        ps = conn.prepareStatement(sql);

        // 7. Set parameters in order
        ps.setString(1, adminNo);
        ps.setString(2, studentName);
        ps.setString(3, fatherName);
        ps.setString(4, email);
        ps.setString(5, fatherNumber);
        ps.setString(6, motherName);
        ps.setString(7, motherNumber);
        ps.setString(8, guardian);
        ps.setString(9, guardianNumber);
        ps.setString(10, address);
        ps.setString(11, className);
        ps.setString(12, aadharNumber);
        ps.setBigDecimal(13, feeAmount);
        ps.setString(14, gender);
        ps.setInt(15, studentAge);
        ps.setDate(16, dobDate);
        ps.setString(17, pincode);

        // 8. Execute the insert
        int i = ps.executeUpdate();

        if (i > 0) {
            out.println("<h3 style='color:green;'>Student Registered Successfully!</h3>");
        } else {
            out.println("<h3 style='color:red;'>Registration Failed!</h3>");
        }

    } catch (SQLException e) {
        if (e.getMessage().contains("Duplicate entry")) {
            out.println("<h3 style='color:red;'>Error: Duplicate entry detected (Admin No, Email or Aadhar may already exist)!</h3>");
        } else {
            out.println("<h3 style='color:red;'>Database Error: " + e.getMessage() + "</h3>");
        }
        e.printStackTrace();
    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
