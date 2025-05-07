package com.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DTO.StudentOrder;
import com.google.gson.Gson;
import com.service.StudentService;

import java.io.*;


@WebServlet("/createOrder")
public class CreateOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            BufferedReader reader = request.getReader();
            StudentOrder student = new Gson().fromJson(reader, StudentOrder.class);
            
            
            System.out.println("Hello RazorPay");
            
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
}
