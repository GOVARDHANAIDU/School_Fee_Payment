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
    private static String admissionNo;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String emailid = req.getParameter("emailid");
        String password = req.getParameter("password");
        String studentId = req.getParameter("studentid");
        String studentPassword = req.getParameter("studentpassword");
        String facultyId = req.getParameter("facultyid");
        String facultyPassword = req.getParameter("facultypassword");
        AdminLoginInter adminLoginInter = new AdminLoginImp();	
        HttpSession session = req.getSession();
        String role = "";
                
        if (emailid != null && password != null) {
            // Checking admin login
            if (adminLoginInter.selectLoginDetails(emailid, password)) {
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                
                session.setAttribute("admissionNo", admissionNo);

                role = "admin";
                session.setAttribute("Roles", role);
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
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                session.setAttribute("admissionNo", admissionNo);
                role = "student";
                session.setAttribute("Roles", role);
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
                session.setAttribute("email", emailid);
                session.setAttribute("adminName", name);
                session.setAttribute("adminId", adminId);
                session.setAttribute("admissionNo", admissionNo);
                role = "faculty";
                session.setAttribute("Roles", role);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
                requestDispatcher.include(req, resp);
            } else {
                req.setAttribute("errorMessage", "Invalid credentials for Faculty.");
                RequestDispatcher dispatcher = req.getRequestDispatcher("AdminLogin.jsp");
                dispatcher.forward(req, resp);
            }
        }
    }
    
    public static void userName(String userName, int id, String admissionNumber) {
        name = userName;
        adminId = id;
        admissionNo = admissionNumber;
    }
}