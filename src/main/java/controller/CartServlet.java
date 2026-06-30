package controller;

import dao.CartDao;
import dao.ProductDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Products;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Cart")
public class CartServlet extends HttpServlet {

    private CartDao cartDAO = new CartDao();
    private ProductDao productDAO = new ProductDao();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        Integer userId = (Integer) session.getAttribute("userId");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                Products p = productDAO.getProductById(productId);

                if (p != null) {
                    CartItem item = new CartItem();
                    item.setProductId(p.getProduct_id());
                    item.setName(p.getName());
                    item.setPrice(p.getPrice());
                    item.setQuantity(1);
                    item.setImage(p.getImage());

                    cartDAO.addToCart(cart, item);

                    if (userId != null) {
                        cartDAO.addToCartDb(userId, productId, 1);
                    }
                }

            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                cartDAO.removeFromCart(cart, productId);

                if (userId != null) {
                    cartDAO.removeFromCartDb(userId, productId);
                }

            } else if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity <= 0) {
                    cartDAO.removeFromCart(cart, productId);
                    if (userId != null) {
                        cartDAO.removeFromCartDb(userId, productId);
                    }
                } else {
                    for (CartItem item : cart) {
                        if (item.getProductId() == productId) {
                            item.setQuantity(quantity);
                            break;
                        }
                    }
                    if (userId != null) {
                        cartDAO.updateCartQtyDb(userId, productId, quantity);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }
}
