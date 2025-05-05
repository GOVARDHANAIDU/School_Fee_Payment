//package com.controller;
//
//
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//
//import org.json.JSONObject;
//import org.springframework.http.ResponseEntity;
//
//import com.DTO.StudentOrder;
//import com.razorpay.RazorpayException;
//import com.service.StudentService;
//
//
//@RestController
//public class StudentController {
//
//    @Autowired
//    private StudentService service;
//
//    @GetMapping("/")
//    public String init() {
//        return "index";
//    }
//
//    @PostMapping("/createOrder")
//    @ResponseBody
//    public ResponseEntity<JSONObject> createOrder(@RequestBody StudentOrder studentOrder) throws RazorpayException {
//        // Create a Razorpay order
//        StudentOrder createdOrder = service.createOrder(studentOrder);
//
//        // Prepare the response data
//        JSONObject response = new JSONObject();
//        response.put("razorpayOrderID", createdOrder.getRazorpayOrderId());
//        response.put("amount", createdOrder.getAmount() ); // Convert to paise
//
//        return ResponseEntity.ok(response);
//    }
//}
