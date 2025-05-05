//package com.DAO;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Repository;
//
//import com.DTO.StudentOrder;
//
//import java.util.List;
//import java.util.Optional;
//
//@Repository
//public class OnlinePayment {
//
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//
//    // Insert a new student order
//    public void save(StudentOrder studentOrder) {
//        String sql = "INSERT INTO student_orders (name, email, phoneNo, course, amount, orderStatus, razorpayOrderID) " +
//                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
//        jdbcTemplate.update(sql, studentOrder.getName(), studentOrder.getEmail(), studentOrder.getPhone(),
//                            studentOrder.getCourse(), studentOrder.getAmount(), studentOrder.getOrderStatus(),
//                            studentOrder.getRazorpayOrderId());
//    }
//
//    // Find an order by its ID
//    public Optional<StudentOrder> findById(Integer orderId) {
//        String sql = "SELECT * FROM student_orders WHERE orderId = ?";
//        List<StudentOrder> orders = jdbcTemplate.query(sql, new Object[]{orderId}, (rs, rowNum) -> {
//            StudentOrder order = new StudentOrder();
//            order.setOrderId(rs.getInt("orderId"));
//            order.setName(rs.getString("name"));
//            order.setEmail(rs.getString("email"));
//            order.setPhone(rs.getString("phoneNo"));
//            order.setCourse(rs.getString("course"));
//            order.setAmount(rs.getInt("amount"));
//            order.setOrderStatus(rs.getString("orderStatus"));
//            order.setRazorpayOrderId(rs.getString("razorpayOrderID"));
//            return order;
//        });
//        return orders.isEmpty() ? Optional.empty() : Optional.of(orders.get(0));
//    }
//
//    // Get all student orders
//    public List<StudentOrder> findAll() {
//        String sql = "SELECT * FROM student_orders";
//        return jdbcTemplate.query(sql, (rs, rowNum) -> {
//            StudentOrder order = new StudentOrder();
//            order.setOrderId(rs.getInt("orderId"));
//            order.setName(rs.getString("name"));
//            order.setEmail(rs.getString("email"));
//            order.setPhone(rs.getString("phoneNo"));
//            order.setCourse(rs.getString("course"));
//            order.setAmount(rs.getInt("amount"));
//            order.setOrderStatus(rs.getString("orderStatus"));
//            order.setRazorpayOrderId(rs.getString("razorpayOrderID"));
//            return order;
//        });
//    }
//}
