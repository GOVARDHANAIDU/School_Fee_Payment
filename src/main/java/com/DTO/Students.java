package com.DTO;

import java.time.LocalDate;

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
   
}
