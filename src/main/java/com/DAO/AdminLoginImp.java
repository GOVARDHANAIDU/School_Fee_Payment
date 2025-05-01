package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.controller.AdminLogin;


public class AdminLoginImp implements AdminLoginInter {
	private static final String select_all ="select * from user_details where Email_ID = ? and Password = ? ";
	@Override
	public boolean selectLoginDetails(String emailid, String password) {
		AdminLogin adminLogin =new AdminLogin();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/SAS_Bank","root", "W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(select_all);
			preparedStatement.setString(1,emailid);
			preparedStatement.setString(2, password);
			ResultSet resultSet = preparedStatement.executeQuery();
			// System.out.println(resultSet);
			
			while (resultSet.isBeforeFirst()) {				
	     	     if(resultSet.next())
			     { 	     	    	
	     	    	String name = resultSet.getString("User_Name");	     	    	
	     			adminLogin.userName(name);
	     			System.out.println(name);
			        return true;
			     }
			     else {			    	 
			       return false;
			     }
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
		return false;
		
	}
}
