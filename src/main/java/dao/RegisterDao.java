package dao;

import util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDao {

    public boolean isUserExists(String uname, String email) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String query = "SELECT 1 FROM users WHERE name = ? OR email = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, uname);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean registerQuery(String uname, String pass, String email) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, uname);
            ps.setString(2, email);
            ps.setString(3, pass); // Password should be hashed before calling this method

            int count = ps.executeUpdate();
            return count > 0;
        }
    }
}
