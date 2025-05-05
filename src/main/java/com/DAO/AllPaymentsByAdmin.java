package com.DAO;

import java.util.List;

import com.DTO.PaymentTransaction;

public interface AllPaymentsByAdmin {
	boolean insertAllPayments(PaymentTransaction paymentTransaction);
	List<PaymentTransaction> selectAllPayments();
	List<PaymentTransaction> selectAllPaymentsByAdmin(int id);
}
