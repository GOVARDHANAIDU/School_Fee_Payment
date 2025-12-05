package com.service;

import com.DAO.DatabaseConnectivity;
import com.DTO.StudentOrder;
import com.controller.CreateOrder;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import org.json.JSONObject;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class StudentService {

    // Replace with your Razorpay Test API credentials
    private static final String RAZORPAY_KEY = "rzp_test_Jmsp2zqLWnGnkA";
    
    private static final String RAZORPAY_SECRET = "dpOUGulZbsgfmreDYTooz36u";
    
    DatabaseConnectivity databaseConnectivity = new DatabaseConnectivity();
    public StudentOrder createRazorpayOrder(StudentOrder student) throws Exception {
        RazorpayClient razorpay = new RazorpayClient(RAZORPAY_KEY, RAZORPAY_SECRET);

        // Razorpay expects amount in paise
        double amountInPaise = student.getAmount() * 100;
        //String class1 = student;

        JSONObject options = new JSONObject();
        options.put("amount", amountInPaise); // amount in paise
        options.put("currency", "INR");
        options.put("receipt", "receipt_" + System.currentTimeMillis());
   //   options.put("course", );
        // Create the order
        Order order = razorpay.orders.create(options);

        // Populate order details in student object
        student.setRazorpayOrderId(order.get("id"));
        student.setOrderStatus(order.get("status"));

        // Optional: Save order info to DB
        saveToDB(student);

        return student;
    }

    private void saveToDB(StudentOrder order) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = databaseConnectivity.getConnection();

        String sql = "INSERT INTO student_orders (name, email, phoneNo, course, amount, date_of_transaction, time_of_transaction, orderStatus, razorpayOrderID, admin_name, admin_no) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        List<String> list = new ArrayList<String>();
        String adminName = "";
        int adminNo = 0;
        for(String name : CreateOrder.setAdminName()) {
        	 adminName = name;
        }
        for(Integer no : CreateOrder.setAdminNo()) {
        	adminNo = no;
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, order.getName());
            stmt.setString(2, order.getEmail());
            stmt.setString(3, order.getPhone());
            stmt.setString(4, order.getCourse());
            stmt.setDouble(5, order.getAmount());
            stmt.setDate(6, Date.valueOf(LocalDate.now()));
            stmt.setTime(7, Time.valueOf(LocalTime.now()));
            stmt.setString(8, order.getOrderStatus());
            stmt.setString(9, order.getRazorpayOrderId());
            stmt.setString(10, adminName);
            stmt.setInt(11, adminNo);

            stmt.executeUpdate();
        } finally {
            conn.close();
        }
    }
}
