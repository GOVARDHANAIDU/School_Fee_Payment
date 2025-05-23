package com.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BillingPage extends HttpServlet{
	// previewthebill.java

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();

	    // Get all form fields
	    String studentName = request.getParameter("studentName");
	    String email = request.getParameter("email");
	    String temp_amount = request.getParameter("amount");
	    double amount = Double.parseDouble(temp_amount);
	    String temp_paidfee = request.getParameter("paidfee");
	    double paidfee = Double.parseDouble(temp_paidfee);
	    String class1 = request.getParameter("class1");
	    String admissionNumber = request.getParameter("admissionnumber");
	    String temp_phone = request.getParameter("phone");
	    long phone = Long.parseLong(temp_phone);
	    String temp_payingfee = request.getParameter("payingfee");
	    double payingfee = Double.parseDouble(temp_payingfee);
	    String paymentMode = request.getParameter("paymentMode");

	    
	    // Set them into session
	    session.setAttribute("studentName", studentName);
	    session.setAttribute("email", email);
	    session.setAttribute("amount", amount);
	    session.setAttribute("paidfee", paidfee);
	    session.setAttribute("class1", class1);
	    session.setAttribute("admissionNumber", admissionNumber);
	    session.setAttribute("phone", phone);
	    session.setAttribute("payingfee", payingfee);
	    session.setAttribute("paymentMode", paymentMode);

	    // Forward to preview page or render directly
	    if(paymentMode.equalsIgnoreCase("online")) {
	    	 request.getRequestDispatcher("payment.jsp").forward(request, response);
	    } else {
	    request.getRequestDispatcher("PreviewPage.jsp").forward(request, response);
	    }
	}

}
