package com.controller;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet("/uploadExcel")
@MultipartConfig
public class CreateClass extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Connected to Database...");
        String className = request.getParameter("className");
        Part filePart = request.getPart("excelFile");
        InputStream fileContent = filePart.getInputStream();

        try (XSSFWorkbook workbook = new XSSFWorkbook(fileContent)) {
            Sheet sheet = workbook.getSheetAt(0);
            Row headerRow = sheet.getRow(0);

            if (headerRow == null) {
                response.getWriter().write("No header row found in the Excel file.");
                return;
            }

            List<String> columnNames = new ArrayList<>();
            for (Cell cell : headerRow) {
                String colName = cell.getStringCellValue().trim();
                if (!colName.matches("[A-Za-z_][A-Za-z0-9_]*")) {
                    response.getWriter().write("Invalid column name: " + colName);
                    return;
                }
                columnNames.add(colName);
            }

            StringBuilder createSQL = new StringBuilder("CREATE TABLE IF NOT EXISTS `" + className + "` (");
            createSQL.append("id INT AUTO_INCREMENT PRIMARY KEY, ");
            for (String col : columnNames) {
                createSQL.append("`").append(col).append("` VARCHAR(255), ");
            }
            createSQL.setLength(createSQL.length() - 2);
            createSQL.append(");");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/academic_details", "root", "W7301@jqir#");

                Statement stmt = conn.createStatement();
                stmt.executeUpdate(createSQL.toString());

                
                
                
                // Now prepare the insert statement
                StringBuilder insertSQL = new StringBuilder("INSERT INTO `" + className + "` (");
                for (String col : columnNames) {
                    insertSQL.append("`").append(col).append("`, ");
                }
                insertSQL.setLength(insertSQL.length() - 2); // remove last comma
                insertSQL.append(") VALUES (");
                for (int i = 0; i < columnNames.size(); i++) {
                    insertSQL.append("?, ");
                }
                insertSQL.setLength(insertSQL.length() - 2); // remove last comma
                insertSQL.append(");");

                PreparedStatement pstmt = conn.prepareStatement(insertSQL.toString());

                // Formatter for reading cell values
                DataFormatter formatter = new DataFormatter();

                // Insert data rows
                for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                    Row row = sheet.getRow(i);
                    if (row == null) continue;

                    for (int j = 0; j < columnNames.size(); j++) {
                        Cell cell = row.getCell(j, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                        String cellValue = formatter.formatCellValue(cell);
                        pstmt.setString(j + 1, cellValue.trim());
                    }
                    pstmt.addBatch();
                }
                pstmt.executeBatch();


                response.getWriter().write("Class '" + className + "' created and data inserted successfully.");
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("Error: " + e.getMessage());
            }
        }
    }
}
