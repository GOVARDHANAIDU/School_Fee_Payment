package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.DAO.AllPaymentsByAdmin;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;
import com.DAO.TransactionPageImp;
import com.DTO.PaymentTransaction;
//import com.service.EmailOTP;
//import com.service.SMSService;

@WebServlet("/addPayment")
public class InsertIntoTransactionHistory extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // ------------- TOKEN VALIDATION ---------------
        String sentToken = req.getParameter("paymentToken");
        String sessionToken = (String) session.getAttribute("paymentToken");
        if (sessionToken == null || !sessionToken.equals(sentToken)) {
            // DUPLICATE SUBMISSION PREVENTED
            resp.sendRedirect("error.jsp?msg=duplicate_refresh_detected");
            return;
        }
        
        // ---------- GET PAYMENT DETAILS ----------
        // Prioritize request parameters (for admin form submission), fallback to session if needed
        String adminNo = req.getParameter("AdmissionNumber");
        if (adminNo == null || adminNo.trim().isEmpty()) {
            adminNo = (String) session.getAttribute("admissionNumber");
        }
        String studentName = req.getParameter("studentName");
        if (studentName == null || studentName.trim().isEmpty()) {
            studentName = (String) session.getAttribute("studentName");
        }
        String emailID = req.getParameter("emailId");
        if (emailID == null || emailID.trim().isEmpty()) {
            emailID = (String) session.getAttribute("email");
        }
        String phoneStr = req.getParameter("phoneNumber");
        long phoneNumber = 0;
        if (phoneStr == null || phoneStr.trim().isEmpty()) {
            phoneStr = (String) session.getAttribute("phone");
        }
        if (phoneStr != null && !phoneStr.trim().isEmpty()) {
            phoneNumber = Long.parseLong(phoneStr);
        }
        String totalFeeStr = req.getParameter("totalFee");
        double totalFee = 0;
        if (totalFeeStr == null || totalFeeStr.trim().isEmpty()) {
            totalFee = (double) session.getAttribute("totalamount");
        } else {
            totalFee = Double.parseDouble(totalFeeStr);
        }
        String paidFeeStr = req.getParameter("paidFee");
        double paidFee = 0;
        if (paidFeeStr == null || paidFeeStr.trim().isEmpty()) {
            paidFee = (double) session.getAttribute("paidfee");
        } else {
            paidFee = Double.parseDouble(paidFeeStr);
        }
        String payingFeeStr = req.getParameter("payingFee");
        double payingFee = 0;
        if (payingFeeStr == null || payingFeeStr.trim().isEmpty()) {
            payingFee = (double) session.getAttribute("payingfee");
        } else {
            payingFee = Double.parseDouble(payingFeeStr);
        }
        String paymentMode = req.getParameter("modeOfPayment");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            paymentMode = (String) session.getAttribute("paymentMode");
        }
        double remainingFee = totalFee - (paidFee + payingFee);
        
        String adminName = (String) session.getAttribute("adminName");
        String class1 = (String) session.getAttribute("class1");
        if (class1 == null || class1.trim().isEmpty()) {
            class1 = (String) session.getAttribute("class1"); // Fallback, but already from session
        }
        int id = (int) session.getAttribute("adminId");
        
        StudentDetailsInter studentDetailsInter = new StudentDetailsImp();
        // Update remaining fee first
        if (studentDetailsInter.updateRemainingFee(adminNo, payingFee)) {
            PaymentTransaction paymentTransaction = new PaymentTransaction();
            paymentTransaction.setAdmin_no(adminNo);
            paymentTransaction.setStudentNAme(studentName);
            paymentTransaction.setEmail(emailID);
            paymentTransaction.setPhone(phoneNumber);
            paymentTransaction.setTotal_fee(totalFee);
            paymentTransaction.setPaidFee(studentDetailsInter.getPaidFee(adminNo));
            paymentTransaction.setPayingFee(payingFee);
            paymentTransaction.setRemaingFee(studentDetailsInter.getbalanceFee(adminNo));
            paymentTransaction.setModeOfPayment(paymentMode);
            paymentTransaction.setAdminName(adminName);
            paymentTransaction.setDateOfTransaction(LocalDate.now());
            paymentTransaction.setTimeOfTransaction(LocalTime.now());
            paymentTransaction.setStudentClass(class1);
            paymentTransaction.setAdminId(id);
            
            AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
            allPaymentsByAdmin.insertAllPayments(paymentTransaction);
            
            // Send email acknowledgement (uncomment if needed)
            // boolean status = EmailOTP.sendFeeAck(
            //     emailID, // <-- send to actual student email
            //     studentName,
            //     adminNo,
            //     totalFee,
            //     paidFee,
            //     payingFee,
            //     remainingFee,
            //     paymentMode
            // );
            
            // // Send SMS Acknowledgment
            // SMSService.sendSMS(
            //     "+91" + phoneNumber,
            //     "SAS School: Fee received for " + studentName +
            //     ". Paid ₹" + payingFee +
            //     ", Balance ₹" + remainingFee + "."
            // );
            
            // ---------- REMOVE TOKEN (VERY IMPORTANT) ----------
            session.removeAttribute("paymentToken");
            
            // Store data in session for receipt (consistent keys)
            session.setAttribute("admissionNumber", adminNo); // For DB query in JSP
            session.setAttribute("studentName", studentName);
            session.setAttribute("email", emailID);
            session.setAttribute("phone", phoneNumber);
            session.setAttribute("class1", class1);
            session.setAttribute("totalamount", totalFee);
            session.setAttribute("paidfee", studentDetailsInter.getPaidFee(adminNo)); // Updated paid
            session.setAttribute("payingfee", payingFee);
            session.setAttribute("remainingBalance", studentDetailsInter.getbalanceFee(adminNo));
            session.setAttribute("paymentMode", paymentMode);
            session.setAttribute("adminName", adminName);
            
            // Post-Redirect-Get: Redirect to JSP (URL becomes /printreceipt.jsp, GET-safe)
            resp.sendRedirect("printreceipt.jsp");
            
        } else {
            // ---------- REMOVE TOKEN ON FAILURE ----------
            session.removeAttribute("paymentToken");
            // Redirect with error (PRG)
            resp.sendRedirect("BillingPage.jsp?error=transaction_failed");
        }
    }
    
    // Handle GET (e.g., direct access or reload attempt) - Redirect to error or billing
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("BillingPage.jsp?error=invalid_access");
    }
}