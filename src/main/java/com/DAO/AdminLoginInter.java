package com.DAO;

public interface AdminLoginInter {
	boolean selectLoginDetails(String emailid, String password);
	boolean selectStudentLoginDetails(String studentId, String studentPassword);
	boolean selectFacultyLoginDetails(String facultyId, String facultyPassword);
	
}
