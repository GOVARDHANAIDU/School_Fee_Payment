package com.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.AdminLoginImp;
import com.DAO.AdminLoginInter;

@WebServlet("/loginpage")
public class AdminLogin extends HttpServlet {
    private static String name;
    private static int adminId;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String emailid = req.getParameter("emailid");
        String password = req.getParameter("password");
        String studentId = req.getParameter("studentid");
        String studentPassword = req.getParameter("studentpassword");
        String facultyId = req.getParameter("facultyid");
        String facultyPassword = req.getParameter("facultypassword");
        AdminLoginInter adminLoginInter = new AdminLoginImp();	
        
//        System.out.println(studentId);
//        System.out.println(studentPassword);
//        System.out.println(facultyId);
//        System.out.println(facultyPassword);

        if (emailid != null && password != null) {
            // Checking admin login
            if (adminLoginInter.selectLoginDetails(emailid, password)) {
                HttpSession session = req.getSession();
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                System.out.println("Admin ID:" + adminId);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
                requestDispatcher.include(req, resp);
            } else {
                req.setAttribute("errorMessage", "Invalid credentials for Admin.");
                RequestDispatcher dispatcher = req.getRequestDispatcher("AdminLogin.jsp");
                dispatcher.forward(req, resp);
            }
        } else if (studentId != null && studentPassword != null) {
            // Checking Student login
            if (adminLoginInter.selectStudentLoginDetails(studentId, studentPassword)) {
                HttpSession session = req.getSession();
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                System.out.println("Admin ID:" + adminId);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
                requestDispatcher.include(req, resp);
            } else {
                req.setAttribute("errorMessage", "Invalid credentials for Student.");
                RequestDispatcher dispatcher = req.getRequestDispatcher("AdminLogin.jsp");
                dispatcher.forward(req, resp);
            }
        } else {
            // Checking Faculty Login
            if (adminLoginInter.selectFacultyLoginDetails(facultyId, facultyPassword)) {
                HttpSession session = req.getSession();
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                System.out.println("Admin ID:" + adminId);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
                requestDispatcher.include(req, resp);
            } else {
                req.setAttribute("errorMessage", "Invalid credentials for Faculty.");
                RequestDispatcher dispatcher = req.getRequestDispatcher("AdminLogin.jsp");
                dispatcher.forward(req, resp);
            }
        }
    }
    
    public static void userName(String userName, int id) {
        name = userName;
        adminId = id;
    }
}