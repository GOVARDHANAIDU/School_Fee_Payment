package com.DTO;

import java.time.LocalDate;


public class Students {
    private int studentId;
    private String adminNo;
    private String studentName;
    private String fatherName;
    private String email;
    private long fatherNumber;
    private String motherName;
    private long motherNumber;
    private String guardianName;
    private long guardianNumber;
    private String address;
    private String studentClass; // Avoid using 'class' as it's a reserved keyword
    private long aadharNumber;
    private double totalFee;
    private String gender;
    private int age;
    private LocalDate dob;
    private int pincode;
    private double paidFee;
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public String getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getFatherName() {
		return fatherName;
	}
	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public long getFatherNumber() {
		return fatherNumber;
	}
	public void setFatherNumber(long fatherNumber) {
		this.fatherNumber = fatherNumber;
	}
	public String getMotherName() {
		return motherName;
	}
	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}
	public long getMotherNumber() {
		return motherNumber;
	}
	public void setMotherNumber(long motherNumber) {
		this.motherNumber = motherNumber;
	}
	public String getGuardianName() {
		return guardianName;
	}
	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}
	public long getGuardianNumber() {
		return guardianNumber;
	}
	public void setGuardianNumber(long guardianNumber) {
		this.guardianNumber = guardianNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStudentClass() {
		return studentClass;
	}
	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}
	public long getAadharNumber() {
		return aadharNumber;
	}
	public void setAadharNumber(long aadharNumber) {
		this.aadharNumber = aadharNumber;
	}
	public double getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(double totalFee) {
		this.totalFee = totalFee;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public LocalDate getDob() {
		return dob;
	}
	public void setDob(LocalDate dob) {
		this.dob = dob;
	}
	public int getPincode() {
		return pincode;
	}
	public void setPincode(int pincode) {
		this.pincode = pincode;
	}
	public double getPaidFee() {
		return paidFee;
	}
	public void setPaidFee(double paidFee) {
		this.paidFee = paidFee;
	}
	@Override
	public String toString() {
		return "Students [studentId=" + studentId + ", adminNo=" + adminNo + ", studentName=" + studentName
				+ ", fatherName=" + fatherName + ", email=" + email + ", fatherNumber=" + fatherNumber + ", motherName="
				+ motherName + ", motherNumber=" + motherNumber + ", guardianName=" + guardianName + ", guardianNumber="
				+ guardianNumber + ", address=" + address + ", studentClass=" + studentClass + ", aadharNumber="
				+ aadharNumber + ", totalFee=" + totalFee + ", gender=" + gender + ", age=" + age + ", dob=" + dob
				+ ", pincode=" + pincode + ", paidFee=" + paidFee + "]";
	}
	public Students(int studentId, String adminNo, String studentName, String fatherName, String email,
			long fatherNumber, String motherName, long motherNumber, String guardianName, long guardianNumber,
			String address, String studentClass, long aadharNumber, double totalFee, String gender, int age,
			LocalDate dob, int pincode, double paidFee) {
		super();
		this.studentId = studentId;
		this.adminNo = adminNo;
		this.studentName = studentName;
		this.fatherName = fatherName;
		this.email = email;
		this.fatherNumber = fatherNumber;
		this.motherName = motherName;
		this.motherNumber = motherNumber;
		this.guardianName = guardianName;
		this.guardianNumber = guardianNumber;
		this.address = address;
		this.studentClass = studentClass;
		this.aadharNumber = aadharNumber;
		this.totalFee = totalFee;
		this.gender = gender;
		this.age = age;
		this.dob = dob;
		this.pincode = pincode;
		this.paidFee = paidFee;
	}
	public Students() {
		super();
		// TODO Auto-generated constructor stub
	}
   
}
