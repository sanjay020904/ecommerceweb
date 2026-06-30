package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Exclude assets, login/register pages/servlets
        boolean isStaticAsset = path.startsWith("/images/") || path.startsWith("/css/") ||
                path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".jpg");
        boolean isPublicPage = path.equals("/login.jsp") || path.equals("/register.jsp") ||
                path.equals("/") || path.equals("/index.jsp");
        boolean isPublicServlet = path.equals("/Login") || path.equals("/Register");

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);

        if (isLoggedIn || isStaticAsset || isPublicPage || isPublicServlet) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {}
}
