package com.DAO;

import java.util.List;

import com.DTO.PaymentTransaction;
import com.DTO.StudentOrder;

public interface AllPaymentsByAdmin {
	boolean insertAllPayments(PaymentTransaction paymentTransaction);
	List<PaymentTransaction> selectAllPayments();
	List<PaymentTransaction> selectAllPaymentsByAdmin(int id);
	List<StudentOrder> selectAllPaymentDetails();
}
