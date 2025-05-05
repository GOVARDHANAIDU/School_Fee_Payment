package com.DTO;

import java.time.LocalDate;
import java.time.LocalTime;




public class FeePayment {
	//payment_id, Student_Name, Paid_Fee, Paying_Fee, Date_of_Payement, Time_of_Payment, Mode_of_Payment, id
	private  int Paymentid;
	private  String Admin_no;
	private  String email;
	private  String phone;
	private  double Total_fee;
	private  String studentName;
	private  String modeOfPayment;
	private  double paidFee;
	private  double payingFee;
	private  LocalDate dateOfTransaction;
	private  LocalTime timeOfTransaction;
	private  int id;
	public FeePayment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getPaymentid() {
		return Paymentid;
	}
	public void setPaymentid(int paymentid) {
		Paymentid = paymentid;
	}
	public String getAdmin_no() {
		return Admin_no;
	}
	public void setAdmin_no(String admin_no) {
		Admin_no = admin_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public double getTotal_fee() {
		return Total_fee;
	}
	public void setTotal_fee(double total_fee) {
		Total_fee = total_fee;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getModeOfPayment() {
		return modeOfPayment;
	}
	public void setModeOfPayment(String modeOfPayment) {
		this.modeOfPayment = modeOfPayment;
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "FeePayment [Paymentid=" + Paymentid + ", Admin_no=" + Admin_no + ", email=" + email + ", phone=" + phone
				+ ", Total_fee=" + Total_fee + ", studentName=" + studentName + ", modeOfPayment=" + modeOfPayment
				+ ", paidFee=" + paidFee + ", payingFee=" + payingFee + ", dateOfTransaction=" + dateOfTransaction
				+ ", timeOfTransaction=" + timeOfTransaction + ", id=" + id + "]";
	}
	
	
	
}
