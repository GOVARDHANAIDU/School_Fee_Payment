package com.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/razorpayWebhook") // Matches the webhook URL
public class BillingPageWebhookHandler extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        StringBuilder payload = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while ((line = reader.readLine()) != null) {
            payload.append(line);
        }

        // Parse the JSON webhook payload
        JsonObject json = JsonParser.parseString(payload.toString()).getAsJsonObject();

        // Get event type like payment.captured, payment.failed etc.
        String eventType = json.get("event").getAsString();
        System.out.println("🔔 Razorpay Webhook Event: " + eventType);

        // Get payment entity info
        JsonObject paymentEntity = json
            .getAsJsonObject("payload")
            .getAsJsonObject("payment")
            .getAsJsonObject("entity");

        // Extract important payment details
        String paymentId = paymentEntity.get("id").getAsString();
        String status = paymentEntity.get("status").getAsString();
        String email = paymentEntity.get("email").getAsString();
        String contact = paymentEntity.get("contact").getAsString();
        double amount = paymentEntity.get("amount").getAsDouble() / 100.0; // Convert paise to rupees

        // Print for debug/logging
        System.out.println("💳 Payment ID: " + paymentId);
        System.out.println("📧 Email: " + email);
        System.out.println("📱 Contact: " + contact);
        System.out.println("💰 Amount: " + amount);
        System.out.println("✅ Payment Status: " + status);

        // TODO: Insert these values into your database here

        // Send 200 OK to Razorpay to confirm receipt
        response.setStatus(HttpServletResponse.SC_OK);
        PrintWriter out = response.getWriter();
        out.write("Webhook received");
    }
}
