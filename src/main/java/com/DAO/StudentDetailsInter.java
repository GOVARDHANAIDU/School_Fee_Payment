package com.DAO;

import java.util.List;

import com.DTO.StudentDetails;

public interface StudentDetailsInter {
	List<StudentDetails> allStudentDetails();
	boolean updateRemainingFee(String admissionNumber, double payingfee);
	double getPaidFee(String admissionNumber);
	double getTotalFee(String admissionNumber);
	double getbalanceFee(String admissionNumber);
}
