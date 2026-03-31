package controller;

import dao.RegisterDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {

        String uname=req.getParameter("uname");
        String pass=req.getParameter("pass");
        String email=req.getParameter("email");
        RegisterDao rd= new RegisterDao();
        try {
            if(rd.registerQuery(uname,pass,email))
            {
                res.sendRedirect("login.jsp");
            }
            else {
                res.sendRedirect("register.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp");
        }

    }
}
