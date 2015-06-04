package forum.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    private final String driver = "com.mysql.jdbc.Driver";
    private final String url = "jdbc:mysql://localhost/bbs";
    private final String dbuser = "root";
    private final String dbpassword = "1234";
    private Connection conn = null;

    public DbConnection() {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            this.conn = DriverManager.getConnection(url, dbuser, dbpassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return this.conn;
    }

    public void closeConnection() {
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}