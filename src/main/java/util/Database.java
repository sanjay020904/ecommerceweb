package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public  class Database {

    public  Connection getConnect() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");
        
        String envUrl = System.getenv("DB_URL");
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASS");

        String url = (envUrl != null && !envUrl.trim().isEmpty()) ? envUrl : "jdbc:mysql://localhost:3306/abc";
        String user = (envUser != null && !envUser.trim().isEmpty()) ? envUser : "root";
        String pass = (envPass != null) ? envPass : "1234";

        return DriverManager.getConnection(url, user, pass);
    }
}
