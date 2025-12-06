//package com.service;
//
//import jakarta.mail.*;
//import jakarta.mail.internet.*;
//import java.util.Properties;
//
//public class EmailOTP {
//
//    // ------------------ SEND OTP EMAIL ------------------
//    public static boolean sendEmail(String recipient, String otp) {
//
//        final String smtpUser = "9d746f001@smtp-brevo.com"; 
//        final String smtpPassword = "qV7bcs4DdJXhrp3W";
//        final String smtpHost = "smtp-relay.brevo.com";
//        final int smtpPort = 587;
//
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", true);
//        props.put("mail.smtp.starttls.enable", true);
//        props.put("mail.smtp.host", smtpHost);
//        props.put("mail.smtp.port", smtpPort);
//
//        Session session = Session.getInstance(props, new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(smtpUser, smtpPassword);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(smtpUser, "SAS School"));
//            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
//            message.setSubject("Your OTP for Login");
//
//            String content = "Dear User,\n\nYour OTP is: " + otp + "\n\nThank you!\nSAS Educational Institution";
//
//            message.setText(content);
//
//            Transport.send(message);
//            return true;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//
//    // ------------------ SEND FEE ACK EMAIL ------------------
//    public static boolean sendFeeAck(String recipient, String studentName, String studentAdmissionNo,
//                                     double totalFee, double paidFee, double payingFee,
//                                     double balance, String paymentMode) {
//
//        final String smtpUser = "9d746f001@smtp-brevo.com"; 
//        final String smtpPassword = "qV7bcs4DdJXhrp3W";
//        final String smtpHost = "smtp-relay.brevo.com";
//        final int smtpPort = 587;
//
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", true);
//        props.put("mail.smtp.starttls.enable", true);
//        props.put("mail.smtp.host", smtpHost);
//        props.put("mail.smtp.port", smtpPort);
//
//        Session session = Session.getInstance(props, new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(smtpUser, smtpPassword);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(smtpUser, "SAS Accounts Department"));
//            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
//            message.setSubject("Fee Payment Acknowledgement");
//
//            String emailContent =
//                    "Dear Parent,\n\n" +
//                    "We acknowledge the successful payment of fees for your ward:\n\n" +
//                    "Student Name: " + studentName + "\n" +
//                    "Admission No: " + studentAdmissionNo + "\n\n" +
//                    "Total Fee: ₹" + String.format("%.2f", totalFee) + "\n" +
//                    "Paid Earlier: ₹" + String.format("%.2f", paidFee) + "\n" +
//                    "Paid Now: ₹" + String.format("%.2f", payingFee) + "\n" +
//                    "Remaining Balance: ₹" + String.format("%.2f", balance) + "\n" +
//                    "Payment Mode: " + paymentMode + "\n\n" +
//                    "Thank you for your timely payment.\n\n" +
//                    "Warm Regards,\n" +
//                    "Accounts Department\n" +
//                    "SAS Educational Institution";
//
//            message.setText(emailContent);
//
//            Transport.send(message);
//            return true;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//}
