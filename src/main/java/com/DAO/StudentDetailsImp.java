package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.DTO.StudentDetails;


//Student_id, Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class
public class StudentDetailsImp implements StudentDetailsInter{
	private static final String selectAll = "Select * from studentfeedetails";
	private static final String update ="UPDATE studentfeedetails SET "
			+ "    Paid_Fee = ? ,"
			+ "    Remaining_fee = ? "
			+ "WHERE Admission_Number = ? ; " ;
	private static final String selectPaidFee = "Select Paid_Fee from studentfeedetails where Admission_Number = ? ";
	private static final String selectTotalFee = "Select Total_Fee from studentfeedetails where Admission_Number = ? ";
	private static final String selectRemainingFee = "Select Remaining_fee from studentfeedetails where Admission_Number= ? ";
	
	@Override
	public List<StudentDetails> allStudentDetails() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectAll);		
			ResultSet resultSet = preparedStatement.executeQuery();
			
			List<com.DTO.StudentDetails> list = new ArrayList<com.DTO.StudentDetails>();
			while (resultSet.next()) {
				
				com.DTO.StudentDetails studentDetails = new com.DTO.StudentDetails();
				studentDetails.setAdmissionNumber(resultSet.getString("Admission_Number"));
				studentDetails.setStudentName(resultSet.getString("Student_Name"));
				studentDetails.setEmailID(resultSet.getString("Email_ID"));
				studentDetails.setPhoneNumber(resultSet.getLong("Phone_Number"));
				studentDetails.setTotalFee(resultSet.getDouble("Total_Fee"));
				studentDetails.setPaidFee(resultSet.getDouble("Paid_Fee"));
				studentDetails.setRemainingFee(resultSet.getDouble("Remaining_fee"));
				studentDetails.setStudentClass(resultSet.getString("Student_Class"));
				list.add(studentDetails);
				
			}
			return list;		
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public boolean updateRemainingFee(String admissionNumber, double payingfee) {
		
		try {
			double paidFee = getPaidFee(admissionNumber) + payingfee;
			double remainingFee = getTotalFee(admissionNumber) - paidFee;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(update);	
     		preparedStatement.setDouble(1, paidFee);
     		preparedStatement.setDouble(2, remainingFee);
			preparedStatement.setString(3, admissionNumber);
			int result = preparedStatement.executeUpdate();
			
				if(result != 0) {		
					
					return true;
				} else {
					return false;
				}			
		   }
			catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		
	}
	@Override
	public double getPaidFee(String admissionNumber) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectPaidFee);		
			preparedStatement.setString(1, admissionNumber);
			ResultSet result = preparedStatement.executeQuery();
			
				if(result.next()) {
					double paidfee = result.getDouble("Paid_Fee");
					System.out.println("Paid Fee: "+ paidfee);
					return paidfee;									
			     }
					
		   }
			catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
		return 0;
	}
	@Override
	public double getTotalFee(String admissionNumber) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectTotalFee);		
			preparedStatement.setString(1, admissionNumber);
			ResultSet result = preparedStatement.executeQuery();
			
				if(result.next()) {
					double totalfee = result.getDouble("Total_Fee");
					System.out.println("Paid Fee: "+ totalfee);
					return totalfee;
								
			  }
					
		   }
			catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
		return 0;
	}
	@Override
	public double getbalanceFee(String admissionNumber) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectRemainingFee);		
			preparedStatement.setString(1, admissionNumber);
			ResultSet result = preparedStatement.executeQuery();
				if(result.next()) {
					double remainingFee = result.getDouble("Remaining_fee");
					return remainingFee;
							
			  }
					
		   }
			catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
		return 0;
	}
	
	 
	

}
