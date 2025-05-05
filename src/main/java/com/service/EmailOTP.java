package com.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailOTP {

    public static boolean sendEmail(String recipient, String otp) {
        final String senderEmail = "govardhannaiduece@gmail.com";
        final String senderPassword = "gnxr sykp reze jrcu"; 

        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Your OTP for Login");
            message.setText("Dear User,\n\nYour OTP is: " + otp + "\n\nThank you!");

            Transport.send(message);

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
