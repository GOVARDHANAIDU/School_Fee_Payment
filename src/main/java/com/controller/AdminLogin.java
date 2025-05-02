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
	private static String name ="";
	
	AdminLoginInter adminLoginInter = new AdminLoginImp();	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    
	     String emailid = req.getParameter("emailid");
	     String password = req.getParameter("password");
	     
	     PrintWriter writer = resp.getWriter();
	     
	     if(adminLoginInter.selectLoginDetails(emailid , password))
	     { 
	    	HttpSession session = req.getSession();
	    	session.setAttribute("email", emailid);
	    	session.setAttribute("userName", name );
	        RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
	        requestDispatcher.include(req, resp);
	     }
	     else {	    	 
	    	 RequestDispatcher dispatcher = req.getRequestDispatcher("AdminLogin.jsp");
			  dispatcher.include(req, resp);
			  writer.println("<script>"); 
			  writer.println("alert('invalid data')"); 			  
			  writer.println("</script>"); 
	     }
	}
	public static void userName(String userName) {
			name = userName;
	}
	
}
