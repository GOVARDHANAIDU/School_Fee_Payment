package com.DTO;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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
	
}
