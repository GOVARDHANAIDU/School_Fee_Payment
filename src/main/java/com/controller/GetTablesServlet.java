package com.controller;

//GetTablesServlet.java
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class GetTablesServlet extends HttpServlet {
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     List<String> tableList = new ArrayList<>();
     try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/YOUR_DB_NAME", "username", "password");
         DatabaseMetaData metaData = con.getMetaData();
         ResultSet rs = metaData.getTables(null, null, "%", new String[] { "TABLE" });
         while (rs.next()) {
             tableList.add(rs.getString("TABLE_NAME"));
         }
         request.setAttribute("tables", tableList);
         RequestDispatcher rd = request.getRequestDispatcher("academicStatus.jsp");
         rd.forward(request, response);
     } catch (Exception e) {
         e.printStackTrace();
     }
 }
}
