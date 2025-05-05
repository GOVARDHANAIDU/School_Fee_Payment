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
            String sql = "INSERT INTO students (admin_no, student_name, father_name, email, father_number, mother_name, mother_number, guardian_name, guardian_number, address, class, aadhar_number, total_fee, gender, age, dob, pincode, paid_fee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                stmt.setString(1, getCellStringValue(row.getCell(0)));  // admin_no
                stmt.setString(2, getCellStringValue(row.getCell(1)));  // student_name
                stmt.setString(3, getCellStringValue(row.getCell(2)));  // father_name
                stmt.setString(4, getCellStringValue(row.getCell(3)));  // email
                stmt.setString(5, getCellStringValue(row.getCell(4)));  // father_number
                stmt.setString(6, getCellStringValue(row.getCell(5)));  // mother_name
                stmt.setString(7, getCellStringValue(row.getCell(6)));  // mother_number
                stmt.setString(8, getCellStringValue(row.getCell(7)));  // guardian_name
                stmt.setString(9, getCellStringValue(row.getCell(8)));  // guardian_number
                stmt.setString(10, getCellStringValue(row.getCell(9))); // address
                stmt.setString(11, getCellStringValue(row.getCell(10))); // class
                stmt.setString(12, getCellStringValue(row.getCell(11))); // aadhar_number
                stmt.setBigDecimal(13, new java.math.BigDecimal(getNumericValue(row.getCell(12)))); // total_fee
                stmt.setString(14, getCellStringValue(row.getCell(13))); // gender
                stmt.setInt(15, (int) getNumericValue(row.getCell(14))); // age
                stmt.setDate(16, new java.sql.Date(parseDateFromCell(row.getCell(15)).getTime())); // dob
                stmt.setString(17, getCellStringValue(row.getCell(16))); // pincode
                stmt.setBigDecimal(18, new java.math.BigDecimal(getNumericValue(row.getCell(17)))); // paid_fee

                stmt.addBatch();
                System.out.println(stmt);
            }

            stmt.executeBatch();
           // System.out.println(stmt);
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
