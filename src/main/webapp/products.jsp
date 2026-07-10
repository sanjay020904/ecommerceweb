<%@ page import="model.Products" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | APEX Store</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Authentication is handled by Filter, but verify session username just in case.
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Products> products = (List<Products>) request.getAttribute("products");
    if (products == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    
    int cartCount = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            cartCount += item.getQuantity();
        }
    }
%>

    <!-- Header Navigation -->
    <header class="navbar">
        <div class="nav-brand">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="color: #6366f1;"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            APEX
        </div>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/products" class="nav-item active" style="color: #6366f1;">Shop</a></li>
            <li class="cart-badge-container">
                <a href="<%= request.getContextPath() %>/cart.jsp" class="nav-item">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>
                    Cart
                </a>
                <% if (cartCount > 0) { %>
                    <span class="cart-badge"><%= cartCount %></span>
                <% } %>
            </li>
            <li class="nav-item" style="border-left: 1px solid rgba(255,255,255,0.15); padding-left: 15px; color: #cbd5e1;">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 4px;"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                <%= username %>
            </li>
            <li><a href="<%= request.getContextPath() %>/logout" class="btn btn-secondary" style="padding: 6px 14px; font-size: 13px;">Logout</a></li>
        </ul>
    </header>

    <!-- Product Grid Section -->
    <main class="products-section">
        <h2 class="section-title">Explore Our Collection</h2>
        <p class="section-subtitle">Curated premium essentials designed for modern lifestyles.</p>

        <div class="products-grid">
            <% 
                if (products != null && !products.isEmpty()) {
                    for (Products p : products) {
            %>
                <div class="product-card">
                    <div class="product-image-container">
                        <img src="<%= p.getImage() %>" alt="<%= p.getName() %>" class="product-image">
                    </div>
                    <div class="product-info">
                        <h3 class="product-name"><%= p.getName() %></h3>
                        <p class="product-price">₹<%= String.format("%,.2f", p.getPrice()) %></p>
                        
                        <div class="product-actions">
                            <form action="<%= request.getContextPath() %>/Cart" method="POST">
                                <input type="hidden" name="productId" value="<%= p.getProduct_id() %>">
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                                    Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <% 
                    }
                } else {
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 50px 0;">
                    <p style="color: var(--text-muted);">No products available in the database.</p>
                </div>
            <% 
                }
            %>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        &copy; 2026 APEX Store. All rights reserved. Designed with ultimate aesthetics.
    </footer>

</body>
</html>
