package com.DTO;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

public class StudentOrder {
    private String name;
    private String email;
    private String phone;
    private Date dateOfPayment;
    private Time timeOfPayment;
    private String course;
    private double amount;
    private String razorpayOrderId;
    private String orderStatus;
    private String adminName;
    private String admissionnumber;
    private double totalfee;
    private double paidfee;
    private int adminNo;
    
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public int getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(int adminNo) {
		this.adminNo = adminNo;
	}
	public StudentOrder() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getCourse() {
		return course;
	}
	
	public double getTotalfee() {
		return totalfee;
	}
	public void setTotalfee(double totalfee) {
		this.totalfee = totalfee;
	}
	public double getPaidfee() {
		return paidfee;
	}
	public void setPaidfee(double paidfee) {
		this.paidfee = paidfee;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
	public String getAdmissionnumber() {
		return admissionnumber;
	}
	public void setAdmissionnumber(String admissionnumber) {
		this.admissionnumber = admissionnumber;
	}
	public String getRazorpayOrderId() {
		return razorpayOrderId;
	}
	public void setRazorpayOrderId(String razorpayOrderId) {
		this.razorpayOrderId = razorpayOrderId;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	
	
	public Date getDateOfPayment() {
		return dateOfPayment;
	}
	public void setDateOfPayment(Date dateOfPayment) {
		this.dateOfPayment = dateOfPayment;
	}
	public Time getTimeOfPayment() {
		return timeOfPayment;
	}
	public void setTimeOfPayment(Time timeOfPayment) {
		this.timeOfPayment = timeOfPayment;
	}
	@Override
	public String toString() {
		return "StudentOrder [name=" + name + ", email=" + email + ", phone=" + phone + ", dateOfPayment="
				+ dateOfPayment + ", timeOfPayment=" + timeOfPayment + ", course=" + course + ", amount=" + amount
				+ ", razorpayOrderId=" + razorpayOrderId + ", orderStatus=" + orderStatus + ", adminName=" + adminName
				+ ", admissionnumber=" + admissionnumber + ", totalfee=" + totalfee + ", paidfee=" + paidfee
				+ ", adminNo=" + adminNo + "]";
	}
	
	
	
	
	
	
    // Getters & Setters
    
}
