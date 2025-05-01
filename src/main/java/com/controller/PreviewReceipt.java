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

import org.apache.tomcat.jni.Local;

import com.DTO.FeePayment;

@WebServlet("/previewthebill")
public class PreviewReceipt extends HttpServlet{
	
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String studentName = request.getParameter("studentName");
	    String admissionNo = request.getParameter("admissionnumber");
	    String email = request.getParameter("email");
	    String temp_phone = request.getParameter("phone");
	   // long phone = Long.parseLong(temp_phone);
	    double amount = Double.parseDouble(request.getParameter("amount"));
	    double paidFee = Double.parseDouble(request.getParameter("paidfee"));
	    double payingFee = Double.parseDouble(request.getParameter("payingfee"));
	    
	    
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
	    
	    RequestDispatcher requestDispatcher = request.getRequestDispatcher("PreviewPage.jsp");
	    requestDispatcher.forward(request, response);
	  }
}
