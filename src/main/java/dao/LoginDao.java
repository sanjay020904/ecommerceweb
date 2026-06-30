package dao;

import util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {

    public Integer authenticateUser(String uname, String pass) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String query = "SELECT user_id FROM users WHERE name = ? AND password = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, uname);
            ps.setString(2, pass); // password should be pre-hashed before calling this
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        }
        return null;
    }

    public Boolean accessQuery(String uname, String pass) throws SQLException, ClassNotFoundException {
        // Kept for simple backwards compatibility, but authenticateUser is preferred.
        return authenticateUser(uname, pass) != null;
    }
}
