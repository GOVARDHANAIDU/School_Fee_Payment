package com.DAO;

public interface ForgotPassword {
	boolean checkingEmailID(String emailid);
	boolean UpdatePassword(String emailid, String confirmPassword, String password);
}
