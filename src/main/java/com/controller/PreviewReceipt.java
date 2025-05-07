package com.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.DTO.FeePayment;

@WebServlet("/previewthebill")
public class PreviewReceipt extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentName = request.getParameter("studentName");
        String admissionNo = request.getParameter("admissionnumber");
        String email = request.getParameter("email");
        String temp_phone = request.getParameter("phone");
        double amount = Double.parseDouble(request.getParameter("amount"));
        double paidFee = Double.parseDouble(request.getParameter("paidfee"));
        double payingFee = Double.parseDouble(request.getParameter("payingfee"));
        String modeOfPayment = request.getParameter("paymentMode");
        String class1 = request.getParameter("class1");

        if (modeOfPayment.equals("Online")) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("payment.jsp");
            requestDispatcher.forward(request, response);
            
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("Class1", class1);

            FeePayment feePayment = new FeePayment();
            feePayment.setStudentName(studentName);
            feePayment.setPaidFee(paidFee);
            feePayment.setEmail(email);
            feePayment.setPhone(temp_phone);
            feePayment.setTotal_fee(amount);
            feePayment.setDateOfTransaction(LocalDate.now());
            feePayment.setTimeOfTransaction(LocalTime.now());
            feePayment.setModeOfPayment("Cash");
            feePayment.setPayingFee(payingFee);

            request.setAttribute("feePayment", feePayment); // Optional: pass to JSP
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("PreviewPage.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
