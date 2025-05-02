package com.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class StudentDetails {
	private int studentId;
	private String admissionNumber;
	private String studentName;
	private long phoneNumber; 
	private String emailID;
	private double totalFee;
	private double paidFee;
	private double remainingFee;
	private String studentClass;
	
}
