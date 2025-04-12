package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:derby://localhost:1527/Tutors_management"; // Replace with your actual database name
        String user = "app"; // Replace with your actual username
        String password = "app123"; // Replace with your actual password
        return DriverManager.getConnection(url, user, password);
    }
}

