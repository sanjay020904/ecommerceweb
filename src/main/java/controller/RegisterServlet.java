package controller;

import dao.RegisterDao;
import util.PasswordHasher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String uname = req.getParameter("uname");
        String pass = req.getParameter("pass");
        String email = req.getParameter("email");
        
        RegisterDao rd = new RegisterDao();
        try {
            if (rd.isUserExists(uname, email)) {
                res.sendRedirect("register.jsp?error=exists");
                return;
            }
            
            String hashedPass = PasswordHasher.hashPassword(pass);
            if (rd.registerQuery(uname, hashedPass, email)) {
                res.sendRedirect("login.jsp?registered=true");
            } else {
                res.sendRedirect("register.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=system");
        }
    }
}
