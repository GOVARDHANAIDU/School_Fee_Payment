package com.DTO;

import lombok.AllArgsConstructor;

public class Parallelinsertioninstudentfee {
	private int studentId;
	private String admissionNumber;
	private String studentName;
	private long phoneNumber; 
	private String emailID;
	private double totalFee;
	private double paidFee;
	private double remainingFee;
	private String studentClass;
	
	public Parallelinsertioninstudentfee() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getStudentId() {
		return studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getAdmissionNumber() {
		return admissionNumber;
	}

	public void setAdmissionNumber(String admissionNumber) {
		this.admissionNumber = admissionNumber;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public long getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(long phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmailID() {
		return emailID;
	}

	public void setEmailID(String emailID) {
		this.emailID = emailID;
	}

	public double getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(double totalFee) {
		this.totalFee = totalFee;
	}

	public double getPaidFee() {
		return paidFee;
	}

	public void setPaidFee(double paidFee) {
		this.paidFee = paidFee;
	}

	public double getRemainingFee() {
		return remainingFee;
	}

	public void setRemainingFee(double remainingFee) {
		this.remainingFee = remainingFee;
	}

	public String getStudentClass() {
		return studentClass;
	}

	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}

	@Override
	public String toString() {
		return "Parallelinsertioninstudentfee [studentId=" + studentId + ", admissionNumber=" + admissionNumber
				+ ", studentName=" + studentName + ", phoneNumber=" + phoneNumber + ", emailID=" + emailID
				+ ", totalFee=" + totalFee + ", paidFee=" + paidFee + ", remainingFee=" + remainingFee
				+ ", studentClass=" + studentClass + "]";
	}
	
	
	
}
