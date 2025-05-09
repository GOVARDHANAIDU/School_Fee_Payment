package com.controller;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet("/upload")
@MultipartConfig
public class insertingBulk extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("file");
        InputStream fileContent = filePart.getInputStream();

        try {
            Workbook workbook = new XSSFWorkbook(fileContent);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

            Sheet sheet = workbook.getSheetAt(0);

            String sql1 = "INSERT INTO students (admin_no, student_name, father_name, email, father_number, mother_name, mother_number, guardian_name, guardian_number, address, class, aadhar_number, total_fee, gender, age, dob, pincode, paid_fee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String sql2 = "INSERT INTO studentfeedetails (Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt1 = conn.prepareStatement(sql1);
            PreparedStatement stmt2 = conn.prepareStatement(sql2);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                String adminNo = getCellStringValue(row.getCell(0));
                String studentName = getCellStringValue(row.getCell(1));
                String fatherName = getCellStringValue(row.getCell(2));
                String email = getCellStringValue(row.getCell(3));
                String fatherNumber = getCellStringValue(row.getCell(4));
                String motherName = getCellStringValue(row.getCell(5));
                String motherNumber = getCellStringValue(row.getCell(6));
                String guardianName = getCellStringValue(row.getCell(7));
                String guardianNumber = getCellStringValue(row.getCell(8));
                String address = getCellStringValue(row.getCell(9));
                String studentClass = getCellStringValue(row.getCell(10));
                String aadharNumber = getCellStringValue(row.getCell(11));
                double totalFee = getNumericValue(row.getCell(12));
                String gender = getCellStringValue(row.getCell(13));
                int age = (int) getNumericValue(row.getCell(14));
                Date dob = parseDateFromCell(row.getCell(15));
                String pincode = getCellStringValue(row.getCell(16));
                double paidFee = getNumericValue(row.getCell(17));
                double remainingFee = totalFee - paidFee;

                // Insert into students
                stmt1.setString(1, adminNo);
                stmt1.setString(2, studentName);
                stmt1.setString(3, fatherName);
                stmt1.setString(4, email);
                stmt1.setString(5, fatherNumber);
                stmt1.setString(6, motherName);
                stmt1.setString(7, motherNumber);
                stmt1.setString(8, guardianName);
                stmt1.setString(9, guardianNumber);
                stmt1.setString(10, address);
                stmt1.setString(11, studentClass);
                stmt1.setString(12, aadharNumber);
                stmt1.setBigDecimal(13, new java.math.BigDecimal(totalFee));
                stmt1.setString(14, gender);
                stmt1.setInt(15, age);
                stmt1.setDate(16, new java.sql.Date(dob.getTime()));
                stmt1.setString(17, pincode);
                stmt1.setBigDecimal(18, new java.math.BigDecimal(paidFee));
                stmt1.addBatch();

                // Insert into studentfeedetails
                stmt2.setString(1, adminNo);
                stmt2.setString(2, studentName);
                stmt2.setString(3, email);
                stmt2.setString(4, fatherNumber); // Main contact
                stmt2.setBigDecimal(5, new java.math.BigDecimal(totalFee));
                stmt2.setBigDecimal(6, new java.math.BigDecimal(paidFee));
                stmt2.setBigDecimal(7, new java.math.BigDecimal(remainingFee));
                stmt2.setString(8, studentClass);
                stmt2.addBatch();
            }

            stmt1.executeBatch();
            stmt2.executeBatch();

            workbook.close();
            conn.close();

            request.setAttribute("uploadSuccess", "Students inserted successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("uploadError", "Error: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("bulkimporting.jsp");
        dispatcher.forward(request, response);
    }

    private String getCellStringValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("dd-MM-yyyy").format(cell.getDateCellValue());
                } else {
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            case FORMULA: return cell.getCellFormula();
            case BLANK:
            default: return "";
        }
    }

    private double getNumericValue(Cell cell) {
        if (cell == null) return 0.0;
        if (cell.getCellType() == CellType.NUMERIC) return cell.getNumericCellValue();
        if (cell.getCellType() == CellType.STRING) {
            try {
                return Double.parseDouble(cell.getStringCellValue().trim());
            } catch (NumberFormatException e) {
                return 0.0;
            }
        }
        return 0.0;
    }

    private Date parseDateFromCell(Cell cell) throws Exception {
        if (cell == null) throw new IllegalArgumentException("DOB cell is null.");

        if (cell.getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(cell)) {
            return cell.getDateCellValue();
        } else if (cell.getCellType() == CellType.STRING) {
            return new SimpleDateFormat("dd-MM-yyyy").parse(cell.getStringCellValue().trim());
        } else {
            throw new IllegalArgumentException("Unsupported date format in DOB cell.");
        }
    }
}
