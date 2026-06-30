package controller;

import dao.LoginDao;
import dao.CartDao;
import model.CartItem;
import util.PasswordHasher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String uname = request.getParameter("uname");
        String pass = request.getParameter("pass");
        
        try {
            LoginDao ld = new LoginDao();
            String hashedPass = PasswordHasher.hashPassword(pass);
            Integer userId = ld.authenticateUser(uname, hashedPass);
            
            if (userId != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", uname);
                session.setAttribute("userId", userId);
                
                // Load cart from database into session
                CartDao cartDao = new CartDao();
                List<CartItem> dbCart = cartDao.getCartFromDb(userId);
                session.setAttribute("cart", dbCart);
                
                response.sendRedirect("products");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system");
        }
    }
}