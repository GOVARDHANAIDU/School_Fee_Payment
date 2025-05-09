package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.service.EmailOTP;

import java.util.Random;
@WebServlet("/otpVerification")

public class TestEmailOtp extends HttpServlet{ 
	ForgotPasswordOTP forgotPasswordOTP = new ForgotPasswordOTP();
   @Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
	    String otp1 = req.getParameter("otp1");
	    String otp2 = req.getParameter("otp2");
	    String otp3 = req.getParameter("otp3");
	    String otp4 = req.getParameter("otp4");
	    String otp5 = req.getParameter("otp5");
	    String otp6 = req.getParameter("otp6");
	    
	    String otp = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
	    String reSend ="";
	    for(String email : ForgotPasswordOTP.setEmail()) {
	    	reSend = email;
	    }
	    	    
    	HttpSession session = req.getSession();
    	String email = (String) session.getAttribute("emailid");
    	String sendedOtp = (String) session.getAttribute("sendedOtp");
    	PrintWriter writer = resp.getWriter();
    	
        System.out.println(otp);
        System.out.println(sendedOtp);
    	if(sendedOtp.equals(otp)) {
    		RequestDispatcher requestDispatcher = req.getRequestDispatcher("NewPassword.jsp");
            requestDispatcher.forward(req, resp);           
    	} else {  			
    		RequestDispatcher dispatcher = req.getRequestDispatcher("forgotPassword.jsp");
			dispatcher.include(req, resp);
			writer.println("<script>"); 
			  writer.println("alert('The OTP will be sent only one time Due to some Security reasons. Try Again..!')"); 			  
			  writer.println("</script>"); 
    	}
    
    }
   
   public static String otpVerification(String email) {   	
   	   String otp1 = generateOTP(6);  
   	   String verifiedEmail = email;
       String recipientEmail = email ;
       
       boolean sendingVerification =  EmailOTP.sendEmail(recipientEmail, otp1);
              
       return otp1;
    
	   }
   
   public static String generateOTP(int length) {
       StringBuilder otp = new StringBuilder();
       Random rand = new Random();
       for (int i = 0; i < length; i++) {
           otp.append(rand.nextInt(10));
       }
       
       return otp.toString();
   }
   
   public static void resendOTP(String email) {
	   otpVerification(email);
   }
}
