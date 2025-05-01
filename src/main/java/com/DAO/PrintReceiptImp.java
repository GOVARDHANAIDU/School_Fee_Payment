package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class PrintReceiptImp implements PrintReceipt{
	private static final String insert = "Insert into student_details(Student_Name, Paid_Fee, Paying_Fee, Date_of_Payement, Time_of_Payment, Mode_of_Payment, id) values(?,?,?,?,?,?,?)";
	
	@Override
	public boolean insertFeePaymentHistory() {
		 try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");
             PreparedStatement preparedStatement = conn.prepareStatement(insert);
             
             
         } catch (Exception e) {
             e.printStackTrace();
         }
		return false;
	}

}
