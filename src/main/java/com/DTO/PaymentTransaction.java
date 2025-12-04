package com.DTO;

import java.time.LocalDate;
import java.time.LocalTime;



public class PaymentTransaction {
	private  int id;
	private  String Admin_no;
	private  String studentNAme;
	private  double Total_fee;
	private  double paidFee;
	private  double payingFee;
	private  double remaingFee;
	private  LocalDate dateOfTransaction;
	private  LocalTime timeOfTransaction;
	private  String modeOfPayment;
	private  String adminName;
	private  long phone;	
	private  String email;
	private String studentClass;
	private int adminId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAdmin_no() {
		return Admin_no;
	}
	public void setAdmin_no(String admin_no) {
		Admin_no = admin_no;
	}
	public String getStudentNAme() {
		return studentNAme;
	}
	public void setStudentNAme(String studentNAme) {
		this.studentNAme = studentNAme;
	}
	public double getTotal_fee() {
		return Total_fee;
	}
	public void setTotal_fee(double total_fee) {
		Total_fee = total_fee;
	}
	public double getPaidFee() {
		return paidFee;
	}
	public void setPaidFee(double paidFee) {
		this.paidFee = paidFee;
	}
	public double getPayingFee() {
		return payingFee;
	}
	public void setPayingFee(double payingFee) {
		this.payingFee = payingFee;
	}
	public double getRemaingFee() {
		return remaingFee;
	}
	public void setRemaingFee(double remaingFee) {
		this.remaingFee = remaingFee;
	}
	public LocalDate getDateOfTransaction() {
		return dateOfTransaction;
	}
	public void setDateOfTransaction(LocalDate dateOfTransaction) {
		this.dateOfTransaction = dateOfTransaction;
	}
	public LocalTime getTimeOfTransaction() {
		return timeOfTransaction;
	}
	public void setTimeOfTransaction(LocalTime timeOfTransaction) {
		this.timeOfTransaction = timeOfTransaction;
	}
	public String getModeOfPayment() {
		return modeOfPayment;
	}
	public void setModeOfPayment(String modeOfPayment) {
		this.modeOfPayment = modeOfPayment;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStudentClass() {
		return studentClass;
	}
	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	@Override
	public String toString() {
		return "PaymentTransaction [id=" + id + ", Admin_no=" + Admin_no + ", studentNAme=" + studentNAme
				+ ", Total_fee=" + Total_fee + ", paidFee=" + paidFee + ", payingFee=" + payingFee + ", remaingFee="
				+ remaingFee + ", dateOfTransaction=" + dateOfTransaction + ", timeOfTransaction=" + timeOfTransaction
				+ ", modeOfPayment=" + modeOfPayment + ", adminName=" + adminName + ", phone=" + phone + ", email="
				+ email + ", studentClass=" + studentClass + ", adminId=" + adminId + "]";
	}
	public PaymentTransaction(int id, String admin_no, String studentNAme, double total_fee, double paidFee,
			double payingFee, double remaingFee, LocalDate dateOfTransaction, LocalTime timeOfTransaction,
			String modeOfPayment, String adminName, long phone, String email, String studentClass, int adminId) {
		super();
		this.id = id;
		Admin_no = admin_no;
		this.studentNAme = studentNAme;
		Total_fee = total_fee;
		this.paidFee = paidFee;
		this.payingFee = payingFee;
		this.remaingFee = remaingFee;
		this.dateOfTransaction = dateOfTransaction;
		this.timeOfTransaction = timeOfTransaction;
		this.modeOfPayment = modeOfPayment;
		this.adminName = adminName;
		this.phone = phone;
		this.email = email;
		this.studentClass = studentClass;
		this.adminId = adminId;
	}
	public PaymentTransaction() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	
	
}
