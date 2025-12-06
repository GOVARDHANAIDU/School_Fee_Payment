//package com.service;
//
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.io.OutputStream;
//
//public class SMSService {
//

//    public static void sendSMS(String phoneNumber, String smsContent) {
//
//        try {
//            URL url = new URL("https://api.brevo.com/v3/transactionalSMS/sms");
//            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//
//            conn.setRequestMethod("POST");
//            conn.setRequestProperty("accept", "application/json");
//            conn.setRequestProperty("api-key", SMS_API_KEY);
//            conn.setRequestProperty("content-type", "application/json");
//            conn.setDoOutput(true);
//
//            String jsonBody = "{"
//                    + "\"sender\":\"SASSCHOOL\","
//                    + "\"recipient\":\"" + 8688093417l + "\","
//                    + "\"content\":\"" + smsContent + "\""
//                    + "}";
//
//            OutputStream os = conn.getOutputStream();
//            os.write(jsonBody.getBytes());
//            os.flush();
//            os.close();
//
//            conn.getResponseCode(); // Sends request
//            conn.disconnect();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}
