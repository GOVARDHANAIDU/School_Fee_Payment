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
import javax.swing.JOptionPane;

import com.DAO.AllPaymentsByAdmin;
import com.DAO.StudentDetailsImp;
import com.DAO.StudentDetailsInter;
import com.DAO.TransactionPageImp;
import com.DTO.PaymentTransaction;
import com.service.EmailOTP;


//transaction_id, student_admission_number, student_name, total_amount, 
//paying_amount, remaining_fee_balance, date_of_payment, time_of_payment,
//mode_of_payment, admin_name
@WebServlet("/addPayment")
public class InsertIntoTransactionHistory extends HttpServlet{
	 @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String adminNo = req.getParameter("AdmissionNumber");
		String studentName = req.getParameter("studentName");
		String emailID = req.getParameter("emailId");
		String tempphoneNumber = req.getParameter("phoneNumber");
		long phoneNumber = Long.parseLong(tempphoneNumber);
		String tempTotalFee = req.getParameter("totalFee");
		double totalFee = Double.parseDouble(tempTotalFee);
		String tempPaidfee = req.getParameter("paidFee");
		double paidFee = Double.parseDouble(tempPaidfee);
		String tempPayingfee = req.getParameter("payingFee");
		double payingfee = Double.parseDouble(tempPayingfee);
		String paymentMode = req.getParameter("modeOfPayment");
		double remainingfee = totalFee - (paidFee +payingfee);
		
		HttpSession session = req.getSession();
		String adminName = (String) session.getAttribute("adminName");
		String class1 = (String) session.getAttribute("class1");
		int id =  (int) session.getAttribute("adminId");
		
		
		
		PaymentTransaction paymentTransaction = new PaymentTransaction();
		
		StudentDetailsInter studentDetailsInter = new StudentDetailsImp();
		
		double paidfee = studentDetailsInter.getPaidFee(adminNo);
		
		if(studentDetailsInter.updateRemainingFee(adminNo, payingfee) ) {
			
		paymentTransaction.setAdmin_no(adminNo);
		paymentTransaction.setStudentNAme(studentName);
		paymentTransaction.setEmail(emailID);
		paymentTransaction.setPhone(phoneNumber);
		paymentTransaction.setTotal_fee(totalFee);
		paymentTransaction.setPaidFee(studentDetailsInter.getPaidFee(adminNo));
		paymentTransaction.setPayingFee(payingfee);
		paymentTransaction.setRemaingFee(studentDetailsInter.getbalanceFee(adminNo));
		paymentTransaction.setModeOfPayment(paymentMode);
		paymentTransaction.setAdminName(adminName);
		paymentTransaction.setDateOfTransaction(LocalDate.now());
		paymentTransaction.setTimeOfTransaction(LocalTime.now());
		paymentTransaction.setStudentClass(class1);
		paymentTransaction.setAdminId(id);
		AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
		allPaymentsByAdmin.insertAllPayments(paymentTransaction);
		
		double balance = totalFee - (paidFee+payingfee);
		
//	    public static boolean sendFeeAck(String recipient, String studentName, String studentAdmissionNo, double totalFee,
//	            double paidFee, double payingFee, double balance, String paymentMode)
		boolean status = EmailOTP.sendFeeAck("dgnaidu19@gmail.com", studentName, adminNo, totalFee, paidFee, payingfee, balance, paymentMode);
		if (status == true) {
		    // Acknowledgement email sent successfully
//		    JOptionPane.showMessageDialog(null, "Fee payment acknowledgement email sent successfully to " + emailID + ".", 
//		                                  "Email Sent", JOptionPane.INFORMATION_MESSAGE);
		    RequestDispatcher requestDispatcher = req.getRequestDispatcher("printreceipt.jsp");
			requestDispatcher.forward(req, resp);
		} else {
		    // Failed to send the email
		    JOptionPane.showMessageDialog(null, "Failed to send fee payment acknowledgement email. Please check the email ID or try again.", 
		                                  "Email Failed", JOptionPane.ERROR_MESSAGE);
		    RequestDispatcher requestDispatcher = req.getRequestDispatcher("printreceipt.jsp");
			requestDispatcher.forward(req, resp);
		}
	
		} else {
			RequestDispatcher requestDispatcher = req.getRequestDispatcher("BillingPage.jsp");
			requestDispatcher.include(req, resp);
			PrintWriter writer = resp.getWriter();
			writer.print("<script>");
			writer.print("alert('Transaction Failed')");
			writer.print("</script>");
		}
	}
}
