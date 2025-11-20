package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.DTO.Parallelinsertioninstudentfee;
import com.DTO.StudentDetails;
import com.DTO.Students;


//Student_id, Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class
public class StudentDetailsImp implements StudentDetailsInter{
	private static final String selectAll = "Select * from studentfeedetails";
	private static final String selectAllStudents = "Select * from students";
	private static final String update ="UPDATE studentfeedetails SET "
			+ "    Paid_Fee = ? ,"
			+ "    Remaining_fee = ? "
			+ "WHERE Admission_Number = ? ;" ;
	private static final String selectPaidFee = "Select Paid_Fee from studentfeedetails where Admission_Number =?";
	private static final String selectTotalFee = "Select Total_Fee from studentfeedetails where Admission_Number =?";
	private static final String selectRemainingFee = "Select Remaining_fee from studentfeedetails where Admission_Number=?";
	private static final String insertall = "insert into studentfeedetails(Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class)"
			+ " values(?,?,?,?,?,?,?,?)";
	private static final String getStudentId = "Select student_id from students where admin_no = ?";
	private static final String updateStudentFee = "update studentfeedetails set "
		    + "Student_Name = ? , Email_ID = ?, Phone_Number=?, Total_Fee = ? , Paid_Fee = ?, "
		    + "Remaining_fee = ? "
		    + "where Student_id = ?;";
//	Student_id, Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class
	DatabaseConnectivity dbConnectivity = new DatabaseConnectivity();
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
	//student_id, admin_no, student_name, father_name, email, father_number, 
	//mother_name, mother_number, guardian_name, guardian_number, address, class,
	//aadhar_number, total_fee, gender, age, dob, pincode, paid_fee
	@Override
	public List<Students> allStudentPersonalDetails() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
			PreparedStatement preparedStatement = connection.prepareStatement(selectAllStudents);		
			ResultSet resultSet = preparedStatement.executeQuery();
			
			List<com.DTO.Students> list = new ArrayList<com.DTO.Students>();
			while (resultSet.next()) {
				
				Students studentDetails = new Students();
				studentDetails.setAdminNo(resultSet.getString("admin_no"));
				studentDetails.setStudentName(resultSet.getString("student_name"));
				studentDetails.setFatherName(resultSet.getString("father_name"));
				studentDetails.setMotherName(resultSet.getString("mother_name"));
				studentDetails.setFatherNumber(resultSet.getLong("father_number"));
				studentDetails.setMotherNumber(resultSet.getLong("mother_number"));
				studentDetails.setGuardianName(resultSet.getString("guardian_name"));
				studentDetails.setGuardianNumber(resultSet.getLong("guardian_number"));
				studentDetails.setAddress(resultSet.getString("address"));
				studentDetails.setStudentClass(resultSet.getString("class"));
				studentDetails.setAadharNumber(resultSet.getLong("aadhar_number"));
				studentDetails.setTotalFee(resultSet.getDouble("total_fee"));
				studentDetails.setGender(resultSet.getString("gender"));
				studentDetails.setAge(resultSet.getInt("age"));
				studentDetails.setDob(resultSet.getDate("dob").toLocalDate());
				studentDetails.setPincode(resultSet.getInt("pincode"));
				studentDetails.setPaidFee(resultSet.getDouble("paid_fee"));
				list.add(studentDetails);
			}
			return list;		
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
			
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
	
//	Student_id, Admission_Number, Student_Name, Email_ID, Phone_Number, Total_Fee, Paid_Fee, Remaining_fee, Student_Class
	@Override
	public boolean insertStudenttofeeDetails(Parallelinsertioninstudentfee studentDetails) {
		
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection =
						DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");
				PreparedStatement preparedStatement = connection.prepareStatement(insertall);
				preparedStatement.setString(1, studentDetails.getAdmissionNumber());
				preparedStatement.setString(2, studentDetails.getStudentName());
				preparedStatement.setString(3, studentDetails.getEmailID());
				preparedStatement.setLong(4, studentDetails.getPhoneNumber());
				preparedStatement.setDouble(5, studentDetails.getTotalFee());
				preparedStatement.setDouble(6, studentDetails.getPaidFee());
				preparedStatement.setDouble(7, studentDetails.getRemainingFee());
				preparedStatement.setString(8, studentDetails.getStudentClass());
				int result = preparedStatement.executeUpdate();
				if(result != 0) {
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
	@Override
	public int getStudentId(String admissionNumber) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =
					DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data","root","W7301@jqir#");	
			PreparedStatement preparedStatement = connection.prepareStatement(getStudentId);
			preparedStatement.setString(1, admissionNumber);
			ResultSet rs = preparedStatement.executeQuery();
			
			if (rs.next()) {
	            int tempId = rs.getInt("student_id");
	            return tempId;
	        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	@Override
	public boolean updateStudentFeeFromManageProfile(List<StudentDetails> studentsFeeUpdatesList) {
		try {
			Connection connection = dbConnectivity.getConnection();
			
			PreparedStatement preparedStatement = connection.prepareStatement(updateStudentFee);
			for(StudentDetails studentlist :studentsFeeUpdatesList ) {
			preparedStatement.setString(1, studentlist.getStudentName());
			preparedStatement.setString(2, studentlist.getEmailID());
			preparedStatement.setLong(3, studentlist.getPhoneNumber());
			preparedStatement.setDouble(4, studentlist.getTotalFee());
			preparedStatement.setDouble(5, studentlist.getPaidFee());
			preparedStatement.setDouble(6, studentlist.getTotalFee() - studentlist.getPaidFee());
			preparedStatement.setInt(7, studentlist.getStudentId());
			}
			int result = preparedStatement.executeUpdate();
			if(result != 0) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
		
}