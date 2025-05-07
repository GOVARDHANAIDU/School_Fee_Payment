package com.DTO;

public class StudentOrder {
    private String name;
    private String email;
    private String phone;
    private String course;
    private int amount;
    private String razorpayOrderId;
    private String orderStatus;
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
	public void setCourse(String course) {
		this.course = course;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
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
	@Override
	public String toString() {
		return "StudentOrder [name=" + name + ", email=" + email + ", phone=" + phone + ", course=" + course
				+ ", amount=" + amount + ", razorpayOrderId=" + razorpayOrderId + ", orderStatus=" + orderStatus + "]";
	}

    // Getters & Setters
    
}
