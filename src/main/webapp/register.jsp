<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | APEX Store</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

    <!-- Navbar -->
    <header class="navbar">
        <div class="nav-brand">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="color: #6366f1;"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            APEX
        </div>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/index.jsp" class="nav-item">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/login.jsp" class="nav-item">Login</a></li>
        </ul>
    </header>

    <!-- Main Auth Card -->
    <main class="auth-container">
        <div class="auth-card">
            <h1 class="auth-title">Register</h1>
            <p class="auth-subtitle">Create your premium eCommerce account</p>

            <%-- Alerts based on request params --%>
            <% 
                String error = request.getParameter("error");
                if ("exists".equals(error)) {
            %>
                <div class="alert alert-danger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    Username or Email already registered.
                </div>
            <% 
                } else if ("failed".equals(error)) {
            %>
                <div class="alert alert-danger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    Registration failed. Please try again.
                </div>
            <% 
                } else if ("system".equals(error)) {
            %>
                <div class="alert alert-danger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    A database connection failure occurred.
                </div>
            <% 
                }
            %>

            <!-- Register Form -->
            <form action="<%= request.getContextPath() %>/Register" method="POST">
                <div class="form-group">
                    <label class="form-label" for="uname">Username</label>
                    <input type="text" id="uname" name="uname" placeholder="e.g. Rohit Kumar" required class="form-input">
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="e.g. rohit@gmail.com" required class="form-input">
                </div>

                <div class="form-group">
                    <label class="form-label" for="pass">Password</label>
                    <input type="password" id="pass" name="pass" placeholder="••••••••" required class="form-input">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 13px;">Create Account</button>

                <p class="auth-footer">
                    Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Login Here</a>
                </p>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        &copy; 2026 APEX Store. All rights reserved. Secure sign-up.
    </footer>
</body>
</html>
