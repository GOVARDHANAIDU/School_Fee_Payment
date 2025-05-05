package com.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.google.gson.Gson;

    
    @WebServlet("/SearchServlet")
    public class SearchServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
            List<Map<String, String>> students = new ArrayList<>();
           

            try {
            	Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root", "W7301@jqir#");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Student_Class, Admission_Number, Remaining_fee FROM studentfeedetails ");
                while (rs.next()) {
                    Map<String, String> student = new HashMap<>();
                    student.put("name", rs.getString("Student_Name"));
                    student.put("email", rs.getString("Email_ID"));
                    student.put("phone", rs.getString("Phone_Number"));
                    student.put("amount", rs.getString("Total_Fee"));
                    student.put("paidfee", rs.getString("Paid_Fee"));
                    student.put("admissionnumber", rs.getString("Admission_Number"));
                    student.put("class1", rs.getString("Student_Class"));
                    student.put("payingfee", rs.getString("Remaining_fee"));
                    students.add(student);
                    
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }

            String json = new Gson().toJson(students);
            response.setContentType("application/json");
            response.getWriter().write(json);
        }
    }
//schoolstudentdetails.database.windows.net
    
    
//    import java.sql.Connection;
//    import java.sql.DriverManager;
//    import java.sql.SQLException;
//
//    public class AzureSqlConnection {
//        public static void main(String[] args) {

//
//            try (Connection conn = DriverManager.getConnection(url)) {
//                System.out.println("Connected to Azure SQL Database!");
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }

