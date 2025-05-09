package com.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DTO.StudentOrder;
import com.google.gson.Gson;
import com.service.StudentService;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/createOrder")
public class CreateOrder extends HttpServlet {
	
	static List<String> list = new ArrayList<>();
	static List<Integer> list1 = new ArrayList<>();
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
    	try {
        	
        	HttpSession session = request.getSession();
        	String adminName = (String) session.getAttribute("adminName");
        	int adminNo = (int) session.getAttribute("adminId");
        	
            list.add(adminName);
        	list1.add(adminNo);
        	
            BufferedReader reader = request.getReader();
            StudentOrder student = new Gson().fromJson(reader, StudentOrder.class);
            
            // ✅ Store each field into separate Java variables
            String name = student.getName();
            String email = student.getEmail();
            String phone = student.getPhone();
            String course = student.getCourse();
            double amount = student.getAmount();
            String admissionNo = student.getAdmissionnumber();
            
            HttpSession session2 = request.getSession();
            session2.setAttribute("admissionNumber", admissionNo);

            
            StudentService service = new StudentService();
            StudentOrder createdOrder = service.createRazorpayOrder(student);
            
            System.out.println("Received from frontend: " + new Gson().toJson(student));
            
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(createdOrder));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server error");
        }
        
         
    }
    public static List<String> setAdminName() {
		return list;		  
	  }
    public static List<Integer> setAdminNo() {
		return list1;		  
	  }
    
    
    
}
