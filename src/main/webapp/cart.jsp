<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | APEX Store</title>
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

    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    
    int cartCount = 0;
    double total = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            cartCount += item.getQuantity();
            total += item.getPrice() * item.getQuantity();
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
            <li><a href="<%= request.getContextPath() %>/products" class="nav-item">Shop</a></li>
            <li class="cart-badge-container">
                <a href="<%= request.getContextPath() %>/cart.jsp" class="nav-item active" style="color: #6366f1;">
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

    <!-- Main Content Container -->
    <main style="flex-grow: 1;">
        <% if (cart == null || cart.isEmpty()) { %>
            <!-- Empty Cart State -->
            <div class="empty-cart-container">
                <div class="empty-cart-icon">🛒</div>
                <h2 class="empty-cart-title">Your Cart is Empty</h2>
                <p class="empty-cart-subtitle">Looks like you haven't added anything to your cart yet.</p>
                <a href="<%= request.getContextPath() %>/products" class="btn btn-primary" style="padding: 12px 30px;">Shop New Products</a>
            </div>
        <% } else { %>
            <!-- Cart Items Grid Layout -->
            <div class="cart-container">
                
                <!-- Left: Items list -->
                <div class="cart-items-list">
                    <% 
                        for (CartItem item : cart) {
                            double itemTotal = item.getPrice() * item.getQuantity();
                    %>
                        <div class="cart-item-row">
                            <div class="cart-item-details">
                                <img src="<%= item.getImage() %>" alt="<%= item.getName() %>" class="cart-item-image">
                                <div class="cart-item-meta">
                                    <h3><%= item.getName() %></h3>
                                    <p>Price: ₹<%= String.format("%,.2f", item.getPrice()) %></p>
                                </div>
                            </div>
                            
                            <div class="cart-item-actions">
                                <!-- Quantity Modification Controls -->
                                <div class="qty-controls">
                                    <form action="<%= request.getContextPath() %>/Cart" method="POST" style="margin: 0;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                        <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                                        <button type="submit" class="qty-btn">&minus;</button>
                                    </form>
                                    <span class="qty-val"><%= item.getQuantity() %></span>
                                    <form action="<%= request.getContextPath() %>/Cart" method="POST" style="margin: 0;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                        <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                        <button type="submit" class="qty-btn">&plus;</button>
                                    </form>
                                </div>

                                <!-- Item Total Cost -->
                                <div class="cart-item-total">
                                    ₹<%= String.format("%,.2f", itemTotal) %>
                                </div>

                                <!-- Remove Button -->
                                <form action="<%= request.getContextPath() %>/Cart" method="POST" style="margin: 0;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                    <button type="submit" class="btn btn-secondary" style="padding: 10px; border-radius: var(--border-radius-sm); color: #f43f5e; border-color: rgba(244,63,94,0.2);">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                                    </button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>

                <!-- Right: Summary Card -->
                <div class="summary-card">
                    <h2 class="summary-title">Order Summary</h2>
                    <div class="summary-row">
                        <span>Subtotal (<%= cartCount %> items)</span>
                        <span>₹<%= String.format("%,.2f", total) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span style="color: #10b981; font-weight: 600;">FREE</span>
                    </div>
                    <div class="summary-row">
                        <span>Tax</span>
                        <span>₹0.00</span>
                    </div>
                    
                    <div class="summary-row total-row">
                        <span>Grand Total</span>
                        <span>₹<%= String.format("%,.2f", total) %></span>
                    </div>

                    <div class="summary-actions">
                        <button class="btn btn-primary" style="padding: 14px;">Proceed to Checkout</button>
                        <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary" style="padding: 12px;">Continue Shopping</a>
                    </div>
                </div>

            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="footer">
        &copy; 2026 APEX Store. All rights reserved. Secured checkout.
    </footer>
</body>
</html>