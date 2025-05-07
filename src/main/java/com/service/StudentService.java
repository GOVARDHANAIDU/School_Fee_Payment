package com.service;

import com.DTO.StudentOrder;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import org.json.JSONObject;

import java.sql.*;

public class StudentService {

    // Replace with your Razorpay Test API credentials
    private static final String RAZORPAY_KEY = "rzp_test_Jmsp2zqLWnGnkA";
    private static final String RAZORPAY_SECRET = "dpOUGulZbsgfmreDYTooz36u";

    public StudentOrder createRazorpayOrder(StudentOrder student) throws Exception {
        RazorpayClient razorpay = new RazorpayClient(RAZORPAY_KEY, RAZORPAY_SECRET);

        // Razorpay expects amount in paise
        int amountInPaise = student.getAmount() * 100;

        JSONObject options = new JSONObject();
        options.put("amount", amountInPaise); // amount in paise
        options.put("currency", "INR");
        options.put("receipt", "receipt_" + System.currentTimeMillis());

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
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

        String sql = "INSERT INTO student_orders (name, email, phoneNo, course, amount, orderStatus, razorpayOrderID) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, order.getName());
            stmt.setString(2, order.getEmail());
            stmt.setString(3, order.getPhone());
            stmt.setString(4, order.getCourse());
            stmt.setInt(5, order.getAmount());
            stmt.setString(6, order.getOrderStatus());
            stmt.setString(7, order.getRazorpayOrderId());

            stmt.executeUpdate();
        } finally {
            conn.close();
        }
    }
}
