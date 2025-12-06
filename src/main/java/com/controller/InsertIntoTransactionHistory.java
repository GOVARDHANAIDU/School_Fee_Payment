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

        String adminNo = req.getParameter("AdmissionNumber");
        String studentName = req.getParameter("studentName");
        String emailID = req.getParameter("emailId");
        long phoneNumber = Long.parseLong(req.getParameter("phoneNumber"));

        double totalFee = Double.parseDouble(req.getParameter("totalFee"));
        double paidFee = Double.parseDouble(req.getParameter("paidFee"));
        double payingFee = Double.parseDouble(req.getParameter("payingFee"));

        String paymentMode = req.getParameter("modeOfPayment");
        double remainingFee = totalFee - (paidFee + payingFee);

        HttpSession session = req.getSession();
        String adminName = (String) session.getAttribute("adminName");
        String class1 = (String) session.getAttribute("class1");
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

            // Send email acknowledgement
//            boolean status = EmailOTP.sendFeeAck(
//                    "govardhannaiduece@gmail.com",        // <-- send to actual student email
//                    studentName,
//                    adminNo,
//                    totalFee,
//                    paidFee,
//                    payingFee,
//                    remainingFee,
//                    paymentMode
//            );
//        

//            // Send SMS Acknowledgment
//            SMSService.sendSMS(
//                    "+91" + 8688093417l,
//                    "SAS School: Fee received for " + studentName +
//                            ". Paid ₹" + payingFee +
//                            ", Balance ₹" + remainingFee + "."
//            );
//
            // Redirect
            RequestDispatcher dispatcher = req.getRequestDispatcher("printreceipt.jsp");
            dispatcher.forward(req, resp);

        } else {
            RequestDispatcher dispatcher = req.getRequestDispatcher("BillingPage.jsp");
            dispatcher.include(req, resp);

            PrintWriter out = resp.getWriter();
            out.print("<script>alert('Transaction Failed');</script>");
        }
    }
}
