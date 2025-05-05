package com.DTO;

import java.time.LocalDate;
import java.time.LocalTime;

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
	
}
