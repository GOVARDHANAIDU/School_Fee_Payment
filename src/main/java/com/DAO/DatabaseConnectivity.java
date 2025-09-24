package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnectivity {
	private static final String URL = "jdbc:mysql://localhost:3306/school_data";
    private static final String USER = "root";
    private static final String PASSWORD = "W7301@jqir#";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }}
