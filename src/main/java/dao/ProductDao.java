package dao;

import model.Products;
import util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

    public List<Products> getProducts() throws SQLException, ClassNotFoundException {
        List<Products> list = new ArrayList<>();
        Database db = new Database();
        String query = "SELECT * FROM products";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Products pr = new Products();
                pr.setProduct_id(rs.getInt("product_id"));
                pr.setName(rs.getString("name"));
                pr.setPrice(rs.getDouble("price"));
                pr.setImage(rs.getString("image"));
                list.add(pr);
            }
        }
        System.out.println("List size: " + list.size());
        return list;
    }

    public Products getProductById(int productId) throws SQLException, ClassNotFoundException {
        Products pr = null;
        Database db = new Database();
        String query = "SELECT * FROM products WHERE product_id = ?";
        try (Connection con = db.getConnect();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pr = new Products();
                    pr.setProduct_id(rs.getInt("product_id"));
                    pr.setName(rs.getString("name"));
                    pr.setPrice(rs.getDouble("price"));
                    pr.setImage(rs.getString("image"));
                } else {
                    System.out.println("No product found with ID: " + productId);
                }
            }
        }
        return pr;
    }
}