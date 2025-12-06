package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnectivity {

	private static final String URL = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&allowPublicKeyRetrieval=true";
	private static final String USER = "root"; 
	private static final String PASSWORD = "IIoeacGMfpglDLjgmSkwTIQoajFikXvz";  
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

//  private static final String URL = "jdbc:mysql://localhost/school_data";
//  private static final String USER = "root";
//  private static final String PASSWORD = "W7301@jqir#";
//  private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
