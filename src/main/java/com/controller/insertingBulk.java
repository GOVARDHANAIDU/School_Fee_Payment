package com.controller;

import java.io.*;
import java.sql.*;
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
            Connection conn = 
            		DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
        
            Sheet sheet = workbook.getSheetAt(0);
            String sql = "INSERT INTO users (name, email, age) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                String name = row.getCell(0).getStringCellValue();
                String email = row.getCell(1).getStringCellValue();
                int age = (int) row.getCell(2).getNumericCellValue();

                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setInt(3, age);
                stmt.addBatch();
            }

            stmt.executeBatch();
            response.getWriter().println("Data inserted successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
