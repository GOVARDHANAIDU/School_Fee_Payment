package com.DTO;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
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
    

}
