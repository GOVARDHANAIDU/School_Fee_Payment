package com.DAO;

import java.util.List;

import com.DTO.Parallelinsertioninstudentfee;
import com.DTO.StudentDetails;
import com.DTO.Students;



public interface StudentDetailsInter {
	List<StudentDetails> allStudentDetails();
	List<Students> allStudentPersonalDetails();
	boolean updateRemainingFee(String admissionNumber, double payingfee);
	double getPaidFee(String admissionNumber);
	double getTotalFee(String admissionNumber);
	double getbalanceFee(String admissionNumber);
	boolean insertStudenttofeeDetails(Parallelinsertioninstudentfee studentDetails);
	
}
