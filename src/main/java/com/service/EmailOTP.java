package com.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailOTP {

    public static boolean sendEmail(String recipient, String otp) {
        final String senderEmail = "dgnaidu19@gmail.com";
        final String senderPassword = "mrks kbsu yrkm lxty"; 

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
    public static boolean sendFeeAck(String recipient, String studentName, String studentAdmissionNo, double totalFee,
            double paidFee, double payingFee, double balance, String paymentMode) {

        final String senderEmail = "dgnaidu19@gmail.com";
        final String senderPassword = "mrks kbsu yrkm lxty"; 

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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Acknowledgement of Fee Payment");

            String emailContent = "Dear Parent,\n\n"
                    + "This is to formally acknowledge the successful payment of fees for your ward, " + studentName
                    + " Admission No: " + studentAdmissionNo + ". A payment of ₹" + String.format("%.2f", payingFee)
                    + " has been received via " + paymentMode + " towards the total payable fee of ₹" + String.format("%.2f", totalFee)
                    + ". Your total paid amount so far stands at ₹" + String.format("%.2f", paidFee)
                    + ", and the remaining balance is ₹" + String.format("%.2f", balance) + ".\n"
                    + "We thank you for your prompt response and continued support. Should you have any questions or require further assistance, please do not hesitate to reach out to the school administration.\n\n"
                    + "Warm regards,\n"
                    + "Accounts Department\n"
                    + "SAS Educational Institution";

            message.setText(emailContent);

            Transport.send(message);

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

}
