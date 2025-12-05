package com.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnectivity {

    private static final String URL = "jdbc:mysql://trolley.proxy.rlwy.net:49592/school_data?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "IIoeacGMfpglDLjgmSkwWIQoajFikXvz";
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
    }
}
