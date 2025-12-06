package com.controller;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.DAO.DatabaseConnectivity;

@WebServlet("/upload")
@MultipartConfig
public class insertingBulk extends HttpServlet {

    private static final SimpleDateFormat OUTPUT_MYSQL = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DatabaseConnectivity db = new DatabaseConnectivity();
        Part filePart = request.getPart("file");
        InputStream fileContent = filePart.getInputStream();

        HttpSession session = request.getSession(false);
        String uploadedBy = (session != null && session.getAttribute("adminName") != null)
                ? session.getAttribute("adminName").toString()
                : "Unknown";

        List<String[]> errorRows = new ArrayList<>();

        // Columns for error sheet
        List<String> headers = Arrays.asList(
                "admin_no", "student_name", "father_name", "email", "father_number",
                "mother_name", "mother_number", "guardian_name", "guardian_number",
                "address", "class", "aadhar_number", "total_fee", "gender",
                "age", "dob", "pincode", "paid_fee", "photo"
        );

        try (Workbook workbook = new XSSFWorkbook(fileContent)) {

            Sheet sheet = workbook.getSheetAt(0);
            Connection conn = db.getConnection();
            conn.setAutoCommit(false); // IMPORTANT

            String sql1 = "INSERT INTO students (admin_no, student_name, father_name, email, father_number, mother_name,"
                    + " mother_number, guardian_name, guardian_number, address, class, aadhar_number, total_fee, gender,"
                    + " age, dob, pincode, paid_fee, photo, last_upload_by, last_upload_time)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

            String sql2 = "INSERT INTO studentfeedetails (Admission_Number, Student_Name, Email_ID, Phone_Number,"
                    + " Total_Fee, Paid_Fee, Remaining_fee, Student_Class)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt1 = conn.prepareStatement(sql1);
            PreparedStatement stmt2 = conn.prepareStatement(sql2);

            boolean hasErrors = false;

            // ----------- Process Each Row ------------
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {

                Row row = sheet.getRow(i);
                if (row == null) continue;

                String[] v = new String[19];

                for (int c = 0; c < 19; c++)
                    v[c] = getCellValue(row.getCell(c));

                // VALIDATION
                String validationError = validate(v);
                if (!validationError.isEmpty()) {
                    hasErrors = true;
                    errorRows.add(addError(v, validationError));
                    continue;
                }

                try {
                    // DATA
                    String adminNo = v[0];
                    String studentName = v[1];
                    String fatherName = v[2];
                    String email = v[3];
                    String fatherNumber = v[4];
                    String motherName = v[5];
                    String motherNumber = v[6];
                    String guardianName = v[7];
                    String guardianNumber = v[8];
                    String address = v[9];
                    String studentClass = normalizeClass(v[10]);
                    String aadhar = v[11];
                    double totalFee = Double.parseDouble(v[12]);
                    String gender = v[13];
                    int age = Integer.parseInt(v[14]);
                    String dob = v[15];
                    String pincode = v[16];
                    double paidFee = Double.parseDouble(v[17]);
                    double remaining = totalFee - paidFee;
                    String photo = v[18];

                    // INSERT 1
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
                    stmt1.setString(12, aadhar);
                    stmt1.setDouble(13, totalFee);
                    stmt1.setString(14, gender);
                    stmt1.setInt(15, age);
                    stmt1.setString(16, dob);
                    stmt1.setString(17, pincode);
                    stmt1.setDouble(18, paidFee);
                    stmt1.setString(19, photo);
                    stmt1.setString(20, uploadedBy);

                    stmt1.executeUpdate(); // EXECUTE SAFELY

                    // INSERT 2
                    stmt2.setString(1, adminNo);
                    stmt2.setString(2, studentName);
                    stmt2.setString(3, email);
                    stmt2.setString(4, fatherNumber);
                    stmt2.setDouble(5, totalFee);
                    stmt2.setDouble(6, paidFee);
                    stmt2.setDouble(7, remaining);
                    stmt2.setString(8, studentClass);

                    stmt2.executeUpdate();

                } catch (SQLIntegrityConstraintViolationException e) {

                    hasErrors = true;
                    errorRows.add(addError(v, "DB Error: " + extractConstraintMessage(e)));

                } catch (SQLException e2) {

                    hasErrors = true;
                    errorRows.add(addError(v, "DB Error: " + e2.getMessage()));

                }
            }

            // EXPORT ERROR FILE IF ANY ERRORS
            if (hasErrors) {
                conn.rollback();
                exportErrorExcel(response, headers, errorRows);
                return;
            }

            conn.commit();
            response.getWriter().write("SUCCESS");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }

    // ---------------------- HELPERS ----------------------

    private String validate(String[] v) {
        if (v[0].isEmpty()) return "Admin Number required";
        if (v[1].isEmpty()) return "Student Name required";

        if (!v[3].matches("^[A-Za-z0-9._%+-]+@(gmail\\.com|email\\.com)$"))
            return "Invalid Email";

        if (!v[4].matches("^[0-9]{10}$"))
            return "Father Number must be 10 digits";

        if (!v[10].matches("^(?:[1-9]|1[0-2])$"))
            return "Class must be 1-12";

        try { OUTPUT_MYSQL.parse(v[15]); }
        catch (Exception e) { return "DOB must be YYYY-MM-DD"; }

        return "";
    }

    private String getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell))
                    return OUTPUT_MYSQL.format(cell.getDateCellValue());
                return String.valueOf((long) cell.getNumericCellValue());
            default: return "";
        }
    }

    private String normalizeClass(String cls) {
        return cls.replaceAll("[^0-9]", "");
    }

    private String[] addError(String[] data, String error) {
        String[] out = Arrays.copyOf(data, data.length + 1);
        out[out.length - 1] = error;
        return out;
    }

    private void exportErrorExcel(HttpServletResponse response, List<String> headers, List<String[]> rows)
            throws IOException {

        XSSFWorkbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Errors");

        Row h = sheet.createRow(0);
        for (int i = 0; i < headers.size(); i++)
            h.createCell(i).setCellValue(headers.get(i));
        h.createCell(headers.size()).setCellValue("Error");

        int r = 1;
        for (String[] rowData : rows) {
            Row row = sheet.createRow(r++);
            for (int c = 0; c < rowData.length; c++)
                row.createCell(c).setCellValue(rowData[c]);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition",
                "attachment; filename=ErrorReport_" + System.currentTimeMillis() + ".xlsx");

        wb.write(response.getOutputStream());
        wb.close();
    }

    private String extractConstraintMessage(Exception e) {
        String msg = e.getMessage();
        if (msg.contains("Duplicate entry"))
            return msg.substring(msg.indexOf("Duplicate entry"));
        return msg;
    }
}
