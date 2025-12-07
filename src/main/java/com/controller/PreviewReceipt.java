package com.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;

@WebServlet("/previewthebill")
public class PreviewReceipt extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get all form fields
        String studentName = request.getParameter("studentName");
        String email = request.getParameter("email");
        String temp_amount = request.getParameter("amount");
        System.out.println("Hello " + temp_amount);
        double amount = Double.parseDouble(temp_amount);
        String temp_paidfee = request.getParameter("paidfee");
        double paidfee = Double.parseDouble(temp_paidfee);
        String class1 = request.getParameter("class1");
        String admissionNumber = request.getParameter("admissionnumber");
        String phone = request.getParameter("phone");
        String temp_payingfee = request.getParameter("payingfee");
        double payingfee = Double.parseDouble(temp_payingfee);
        String paymentMode = request.getParameter("paymentMode");
        
        // Set them into session
        session.setAttribute("studentName", studentName);
        session.setAttribute("email", email);
        session.setAttribute("totalamount", amount);
        session.setAttribute("paidfee", paidfee);
        session.setAttribute("class1", class1);
        session.setAttribute("admissionNumber", admissionNumber);
        session.setAttribute("phone", phone);
        session.setAttribute("payingfee", payingfee);
        session.setAttribute("paymentMode", paymentMode);
        
        // Generate secure CSRF token for payment form
        SecureRandom random = new SecureRandom();
        byte[] tokenBytes = new byte[32];
        random.nextBytes(tokenBytes);
        String paymentToken = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
        session.setAttribute("paymentToken", paymentToken);
        
        // Post-Redirect-Get: Redirect to avoid resubmission on refresh
        if (paymentMode.equalsIgnoreCase("online")) {
            response.sendRedirect("payment.jsp");
        } else {
            response.sendRedirect("PreviewPage.jsp");
        }
    }
    
    // Handle GET: Load from session if data exists, else redirect to billing
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if preview data exists in session
        if (session.getAttribute("studentName") == null || session.getAttribute("paymentToken") == null) {
            // No data: Redirect to billing/search
            response.sendRedirect("BillingPage.jsp?msg=no_preview_data");
            return;
        }
        
        // Data exists: Forward to appropriate JSP
        String paymentMode = (String) session.getAttribute("paymentMode");
        if (paymentMode != null && paymentMode.equalsIgnoreCase("online")) {
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } else {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("PreviewPage.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}