<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fashionhub.model.OrderHistoryRow"%>
<%
    @SuppressWarnings("unchecked")
    ArrayList<OrderHistoryRow> rows = (ArrayList<OrderHistoryRow>) request.getAttribute("orderRows");
    if (rows == null) {
        rows = new ArrayList<>();
    }
    String ordersFlash = (String) request.getAttribute("ordersFlash");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | FashionHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/nav-account.css">
    <link rel="stylesheet" href="<%= ctx %>/css/orders.css">
</head>
<body class="home-page loaded orders-page">

<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<main class="orders-shell">
    <div class="container">

        <% if (ordersFlash != null) { %>
        <div class="orders-flash" role="status"><i class="fas fa-circle-check"></i> <%= ordersFlash %></div>
        <% } %>

        <div class="orders-head">
            <div>
                <h1 class="orders-title">My orders</h1>
            </div>
        </div>

        <% if (rows.isEmpty()) { %>
        <div class="orders-empty">
            <p>You have not placed any orders yet.</p>
            <p style="margin-top:10px;"><a href="<%= ctx %>/ProductController">Continue shopping</a> &middot;
                <a href="<%= ctx %>/ViewCartController">View bag</a></p>
        </div>
        <% } else { %>
        <div class="orders-grid">
            <% for (OrderHistoryRow r : rows) {
                double lineTotal = r.getQuantity() * r.getUnitPrice();
            %>
            <article class="order-card">
                <div class="order-card__top">
                    <div class="order-pills">
                        <span class="pill pill--accent"><i class="fas fa-hashtag"></i> Order <%= r.getOrderId() %></span>
                        <span class="pill"><i class="far fa-calendar"></i> <%= r.getOrderDate() %></span>
                        <span class="pill"><i class="fas fa-truck-fast"></i> Delivery <%= r.getDeliveryDate() %></span>
                    </div>
                    <div class="order-status"><%= r.getStatusLabel() %></div>
                </div>
                <div class="order-card__body">
                    <img class="order-img" src="<%= r.getProductImage() %>" alt="<%= r.getProductName() %>">
                    <div class="order-meta">
                        <div class="order-line-title"><%= r.getProductName() %></div>
                        <div class="order-line-sub">Quantity: <strong><%= r.getQuantity() %></strong></div>
                        <div class="order-line-price">&#8377;<%= String.format("%.2f", r.getUnitPrice()) %> <span class="order-line-sub">per unit</span></div>
                        <div class="order-line-total">Line total: <strong>&#8377;<%= String.format("%.2f", lineTotal) %></strong></div>
                    </div>
                </div>
            </article>
            <% } %>
        </div>
        <% } %>

    </div>
</main>
	<footer class="footer">
		<div class="container footer-grid">
			<div class="footer-brand">
				<div class="logo logo-footer">
					FASHION<span>HUB</span>
				</div>
				<p>Curating modern elegance through premium curated
					collections. Crafted for the modern era.</p>
				<div class="social-links">
					<a href="#"><i class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-twitter"></i></a>
				</div>
			</div>
			<div class="footer-col">
				<h4>Shop Categories</h4>
				<a href="#">Men's Clothing</a><a href="#">Women's Styles</a><a
					href="#">Kids Collection</a><a href="#">Premium Accessories</a><a
					href="#">Footwear Hub</a>
			</div>
			<div class="footer-col">
				<h4>Support & Help</h4>
				<a href="#">Contact Us</a><a href="#">Shipping Details</a><a
					href="#">Order Tracking</a><a href="#">Refund Policy</a><a href="#">FAQ's</a>
			</div>
			<div class="footer-col">
				<h4>Information</h4>
				<a href="#">About FashionHub</a><a href="#">Privacy Policy</a><a
					href="#">Terms & Conditions</a><a href="#">Sustainability</a><a
					href="#">Work with us</a>
			</div>
		</div>
		<div class="footer-bottom">
			<div class="container footer-flex-bottom">
				<p>&copy; 2024 FashionHub. All Rights Reserved.</p>

			</div>
		</div>
	</footer>
<script>
    const searchBox = document.querySelector(".search-box");
    const searchBtn = document.querySelector(".search-toggle");
    const navLinks = document.querySelector(".nav-links");
    if (searchBox && searchBtn) {
        searchBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            searchBox.classList.toggle("active");
            if (navLinks) navLinks.classList.toggle("shrink");
        });
        document.addEventListener("click", (e) => {
            if (!searchBox.contains(e.target)) {
                searchBox.classList.remove("active");
                if (navLinks) navLinks.classList.remove("shrink");
            }
        });
    }
</script>

</body>
</html>
