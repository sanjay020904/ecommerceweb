<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apex Store | Premium E-Commerce</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

    <!-- Header Navigation -->
    <header class="navbar">
        <div class="nav-brand">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="color: #6366f1;"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            APEX
        </div>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/products" class="nav-item">Shop</a></li>
            <li><a href="<%= request.getContextPath() %>/login.jsp" class="nav-item">Login</a></li>
            <li><a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-primary" style="padding: 8px 18px;">Register</a></li>
        </ul>
    </header>

    <!-- Hero Section -->
    <main class="hero-section">
        <h1 class="hero-title">Experience the Future <br>of E-Commerce</h1>
        <p class="hero-subtitle">Discover curated premium products built with cutting-edge design, high performance, and absolute security.</p>
        <div style="display: flex; gap: 15px; justify-content: center;">
            <a href="<%= request.getContextPath() %>/products" class="btn btn-primary" style="padding: 14px 30px; font-size: 16px;">Shop Collection</a>
            <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-secondary" style="padding: 14px 30px; font-size: 16px;">Get Started</a>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        &copy; 2026 APEX Store. All rights reserved. Designed for ultimate premium experience.
    </footer>

</body>
</html>
