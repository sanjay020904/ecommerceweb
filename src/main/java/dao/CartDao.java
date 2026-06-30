package dao;

import model.CartItem;
import util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    // --- SESSION METHODS ---
    
    public void addToCart(List<CartItem> cart, CartItem newItem) {
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == newItem.getProductId()) {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }
        if (!found) {
            cart.add(newItem);
        }
    }

    public void removeFromCart(List<CartItem> cart, int productId) {
        cart.removeIf(item -> item.getProductId() == productId);
    }

    public double getTotal(List<CartItem> cart) {
        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }

    // --- DATABASE PERSISTENCE METHODS ---

    // Load cart from database
    public List<CartItem> getCartFromDb(int userId) throws SQLException, ClassNotFoundException {
        List<CartItem> cart = new ArrayList<>();
        Database db = new Database();
        String query = "SELECT c.product_id, c.quantity, p.name, p.price, p.image FROM cart c " +
                       "JOIN products p ON c.product_id = p.product_id WHERE c.user_id = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setName(rs.getString("name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImage(rs.getString("image"));
                    cart.add(item);
                }
            }
        }
        return cart;
    }

    // Add or increment item in database
    public void addToCartDb(int userId, int productId, int quantity) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        try (Connection con = db.getConnect()) {
            boolean exists = false;
            int existingQty = 0;
            try (PreparedStatement checkPs = con.prepareStatement(checkQuery)) {
                checkPs.setInt(1, userId);
                checkPs.setInt(2, productId);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        exists = true;
                        existingQty = rs.getInt("quantity");
                    }
                }
            }

            if (exists) {
                String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                try (PreparedStatement updatePs = con.prepareStatement(updateQuery)) {
                    updatePs.setInt(1, existingQty + quantity);
                    updatePs.setInt(2, userId);
                    updatePs.setInt(3, productId);
                    updatePs.executeUpdate();
                }
            } else {
                String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertPs = con.prepareStatement(insertQuery)) {
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, productId);
                    insertPs.setInt(3, quantity);
                    insertPs.executeUpdate();
                }
            }
        }
    }

    // Update quantity directly in database
    public void updateCartQtyDb(int userId, int productId, int quantity) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String query = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            ps.executeUpdate();
        }
    }

    // Remove item from database
    public void removeFromCartDb(int userId, int productId) throws SQLException, ClassNotFoundException {
        Database db = new Database();
        String query = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        }
    }
}
