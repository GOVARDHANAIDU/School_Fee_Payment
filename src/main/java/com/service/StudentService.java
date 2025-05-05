//package com.service;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//
//import javax.sql.DataSource;
//
//import org.json.JSONObject;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Service;
//
//import com.DTO.StudentOrder;
//import com.razorpay.Order;
//import com.razorpay.RazorpayClient;
//import com.razorpay.RazorpayException;
//
//@Service
//public class StudentService {
//
//    @Autowired
//    private DataSource dataSource;
//
//    @Value("${razorpay.key.id}")
//    private String razorpayKey;
//
//    @Value("${razorpay.secret.key}")
//    private String razorPaySecert;
//
//    private RazorpayClient client;
//
//    public StudentOrder createOrder(StudentOrder studentOrder) throws RazorpayException {
//        // Create a JSON object to send to Razorpay
//        JSONObject orderReq = new JSONObject();
//        orderReq.put("amount", studentOrder.getAmount() ); // Amount in paise
//        orderReq.put("currency", "INR");
//        orderReq.put("receipt", studentOrder.getEmail());
//
//        // Razorpay client setup
//        this.client = new RazorpayClient(razorpayKey, razorPaySecert);
//        
//        // Create the Razorpay order
//        Order razorPayOrder = client.orders.create(orderReq);
//
//        // Set Razorpay order ID and status to StudentOrder
//        studentOrder.setRazorpayOrderId(razorPayOrder.get("id"));
//        studentOrder.setOrderStatus(razorPayOrder.get("status"));
//
//        // Save the order to the database
//        saveStudentOrder(studentOrder); // This is where the database interaction happens
//
//        return studentOrder;
//    }
//
//    private void saveStudentOrder(StudentOrder order) {
//        String sql = "INSERT INTO student_orders (name, email, phoneNo, course, amount, orderStatus, razorpayOrderID) " +
//                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
//
//        try {
//        	 
//        	Class.forName("com.mysql.cj.jdbc.Driver");
//        	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
//        
//             PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, order.getName());
//            stmt.setString(2, order.getEmail());
//            stmt.setString(3, order.getPhone());
//            stmt.setString(4, order.getCourse());
//            stmt.setInt(5, order.getAmount());
//            stmt.setString(6, order.getOrderStatus()); // Order status from Razorpay
//            stmt.setString(7, order.getRazorpayOrderId());
//
//            stmt.executeUpdate();
//
//        } catch (SQLException e) {
//            throw new RuntimeException("Error inserting order into database", e);
//        } catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    }
//
//}
