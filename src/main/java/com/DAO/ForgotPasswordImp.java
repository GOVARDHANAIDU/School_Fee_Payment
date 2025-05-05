package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ForgotPasswordImp implements ForgotPassword {
	private static final String select = "Select * from admin_registration where email = ?";
	private static final String update = "update admin_registration set password= ?, confirm_password = ? where email = ?";
	String url = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12773883"; // Host & DB name
        String username = "sql12773883";   // Hosting DB username
        String password = "r71iFqJHWT";   // Hosting DB password
	@Override
	public boolean checkingEmailID(String emailid) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(select);
			preparedStatement.setString(1, emailid);
			ResultSet resultSet = preparedStatement.executeQuery();
			while(resultSet.isBeforeFirst())
			{
				if(resultSet.next()) {
					return true;				
				} else {				
					return false;
				}
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			
			e.printStackTrace();
			return false;
		}
		return false;
	}

	@Override
	public boolean UpdatePassword(String emailid, String confirmPassword, String password) {
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(update);
			
			preparedStatement.setString(1, password);
			preparedStatement.setString(2, confirmPassword);
			preparedStatement.setString(3, emailid);
			
			int result = preparedStatement.executeUpdate();
			System.out.println(result);
			if(result != 0)
			{
				return true;
			} else {
				return false;
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
			
	}
	

}





