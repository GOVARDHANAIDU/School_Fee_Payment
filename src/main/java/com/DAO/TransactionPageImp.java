package com.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.DTO.PaymentTransaction;

public class TransactionPageImp implements AllPaymentsByAdmin {
	private static final String insertDetails =
			"insert into transactions(student_admission_number, student_name, total_amount, Last_Paid_Amount, remaining_fee_balance, date_of_payment, "
			+ "time_of_payment, mode_of_payment, admin_name, phone_number, Email_ID,Paid_amount,Student_Class,admin_id)"
			+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String selectAll = "Select * from transactions";
	private static final String selectAllOfAdmin = "Select * from transactions where admin_id = ?";
	@Override
	public boolean insertAllPayments(PaymentTransaction paymentTransaction) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(insertDetails);
			preparedStatement.setString(1, paymentTransaction.getAdmin_no());
			preparedStatement.setString(2, paymentTransaction.getStudentNAme());
			preparedStatement.setDouble(3, paymentTransaction.getTotal_fee());
			preparedStatement.setDouble(4, paymentTransaction.getPayingFee());
			preparedStatement.setDouble(5, paymentTransaction.getRemaingFee());
			preparedStatement.setDate(6, Date.valueOf(paymentTransaction.getDateOfTransaction()));
			preparedStatement.setTime(7, Time.valueOf(paymentTransaction.getTimeOfTransaction()));
			preparedStatement.setString(8, paymentTransaction.getModeOfPayment());
			preparedStatement.setString(9, paymentTransaction.getAdminName());
			preparedStatement.setLong(10, paymentTransaction.getPhone());
			preparedStatement.setString(11,paymentTransaction.getEmail());
			preparedStatement.setDouble(12, paymentTransaction.getPaidFee());
			preparedStatement.setString(13, paymentTransaction.getStudentClass());
			preparedStatement.setInt(14, paymentTransaction.getAdminId());
			int result = preparedStatement.executeUpdate();
			System.out.println(preparedStatement);
			if(result != 0) {
				return true;
			} else {
				return false;
			}

		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
	//transaction_id, student_admission_number, student_name, Student_Class, total_amount, Last_Paid_Amount, Paid_amount,
	//remaining_fee_balance, date_of_payment, time_of_payment, mode_of_payment, phone_number, Email_ID, admin_name
	@Override
	public List<PaymentTransaction> selectAllPayments() {
	    try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = 
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectAll);
			
			ResultSet resultSet = preparedStatement.executeQuery();
			List<PaymentTransaction> list = new ArrayList<PaymentTransaction>();
			while(resultSet.next()) {
				PaymentTransaction paymentTransaction = new PaymentTransaction();
				paymentTransaction.setAdmin_no(resultSet.getString("student_admission_number"));
				paymentTransaction.setStudentNAme(resultSet.getString("student_name"));
				paymentTransaction.setStudentClass(resultSet.getString("Student_Class"));
				paymentTransaction.setTotal_fee(resultSet.getDouble("total_amount"));
				paymentTransaction.setPaidFee(resultSet.getDouble("Last_Paid_Amount"));
				paymentTransaction.setPaidFee(resultSet.getDouble("Paid_amount"));
				paymentTransaction.setRemaingFee(resultSet.getDouble("remaining_fee_balance"));
				paymentTransaction.setDateOfTransaction(resultSet.getDate("date_of_payment").toLocalDate());
				paymentTransaction.setTimeOfTransaction(resultSet.getTime("time_of_payment").toLocalTime());
				paymentTransaction.setModeOfPayment(resultSet.getString("mode_of_payment"));
				paymentTransaction.setPhone(resultSet.getLong("phone_number"));
				paymentTransaction.setEmail(resultSet.getString("Email_ID"));
				paymentTransaction.setAdminName(resultSet.getString("admin_name"));
				list.add(paymentTransaction);
			}
			return list;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		return null;
	}

	@Override
	public List<PaymentTransaction> selectAllPaymentsByAdmin(int id) {
	    try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = 
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectAllOfAdmin);
			
			preparedStatement.setInt(1,id);
			ResultSet resultSet = preparedStatement.executeQuery();
			System.out.println(preparedStatement);
			List<PaymentTransaction> list = new ArrayList<PaymentTransaction>();
			while(resultSet.next()) {
				PaymentTransaction paymentTransaction = new PaymentTransaction();
				paymentTransaction.setAdmin_no(resultSet.getString("student_admission_number"));
				paymentTransaction.setStudentNAme(resultSet.getString("student_name"));
				paymentTransaction.setStudentClass(resultSet.getString("Student_Class"));
				paymentTransaction.setTotal_fee(resultSet.getDouble("total_amount"));
				paymentTransaction.setPaidFee(resultSet.getDouble("Last_Paid_Amount"));
				paymentTransaction.setPaidFee(resultSet.getDouble("Paid_amount"));
				paymentTransaction.setRemaingFee(resultSet.getDouble("remaining_fee_balance"));
				paymentTransaction.setDateOfTransaction(resultSet.getDate("date_of_payment").toLocalDate());
				paymentTransaction.setTimeOfTransaction(resultSet.getTime("time_of_payment").toLocalTime());
				paymentTransaction.setModeOfPayment(resultSet.getString("mode_of_payment"));
				paymentTransaction.setPhone(resultSet.getLong("phone_number"));
				paymentTransaction.setEmail(resultSet.getString("Email_ID"));
				paymentTransaction.setAdminName(resultSet.getString("admin_name"));
				list.add(paymentTransaction);
			}
			return list;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		return null;
	}
}
