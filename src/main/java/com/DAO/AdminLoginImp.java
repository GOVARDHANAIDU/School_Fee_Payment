package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.controller.AdminLogin;


public class AdminLoginImp implements AdminLoginInter {
	private static final String select_all ="select * from admin_registration where email = ? and password = ? ";
	private static final String select_all_student_details = "select * from students where admin_no = ? and dob = ?";
	private static final String select_all_faculty_details = "select * from faculty where email = ? and confirm_password = ?";
	AdminLogin adminLogin =new AdminLogin();
	DatabaseConnectivity databaseConnectivity = new DatabaseConnectivity();
	@Override
	public boolean selectLoginDetails(String emailid, String password) {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = databaseConnectivity.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(select_all);
			preparedStatement.setString(1,emailid);
			preparedStatement.setString(2, password);
			ResultSet resultSet = preparedStatement.executeQuery();
			// System.out.println(resultSet);
			
			while (resultSet.isBeforeFirst()) {				
	     	     if(resultSet.next())
			     { 	     	    	
	     	    	String name = resultSet.getString("name");	     	    	
	     	    	int id = resultSet.getInt("id");	     	    	
	     			adminLogin.userName(name, id);
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
	@Override
	public boolean selectStudentLoginDetails(String studentId,  String studentPassword) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = databaseConnectivity.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(select_all_student_details);
			preparedStatement.setString(1, studentId);
			preparedStatement.setString(2, studentPassword);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while (resultSet.isBeforeFirst()) {				
	     	     if(resultSet.next())
			     { 	
	     	    	String name = resultSet.getString("student_name");	
	     	    	int id = resultSet.getInt("student_id");	     	    	
	     			adminLogin.userName(name, id);
			        return true;
			     }
			     else {	
			       return false;
			     }			
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;

		}
		return false;
	}
	@Override
	public boolean selectFacultyLoginDetails(String facultyId, String facultyPassword) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = databaseConnectivity.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(select_all_faculty_details);
			preparedStatement.setString(1, facultyId);
			preparedStatement.setString(2, facultyPassword);
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while(resultSet.isBeforeFirst()) {
				if(resultSet.next() && resultSet.getString("status").equalsIgnoreCase("Active")) {
					String name = resultSet.getString("name");	
	     	    	int id = resultSet.getInt("id");	     	    	
	     			adminLogin.userName(name, id);
			        return true;
			     }
			     else {	
			       return false;
			     }			
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return false;

	}
}
