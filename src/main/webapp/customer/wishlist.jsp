<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fashionhub.model.Product"%>
<%
    @SuppressWarnings("unchecked")
    ArrayList<Product> wishlistProducts = (ArrayList<Product>) request.getAttribute("wishlistProducts");
    if (wishlistProducts == null) {
        wishlistProducts = new ArrayList<>();
    }
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist | FashionHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/nav-account.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="home-page loaded fh-shop-page">

<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

    <div class="fh-shop-wrap">
        <h2 class="fh-wl-title">Your wishlist</h2>
        <% if (wishlistProducts.isEmpty()) { %>
            <p class="fh-empty">No saved items yet.</p>
        <% } else { %>
       <div class="product-grid">

<% for (Product p : wishlistProducts) { %>

<div class="product-card">

    <div class="card-header bg-pale">

        <!-- RED HEART -->
        <button class="wishlist-btn-card active"
                onclick="removeWishlist(this, <%= p.getProductId() %>)">

            <i class="fas fa-heart" style="color:red;"></i>

        </button>

        <img src="<%= p.getImage() %>"
             class="product-img"
             alt="<%= p.getName() %>">

    </div>

    <div class="card-body">

        <h3><%= p.getName() %></h3>

        <div class="price-action">

            <span class="price-text">
                ₹<%= p.getPrice() %>
            </span>

            <a href="<%= ctx %>/ProductController?id=<%= p.getProductId() %>"
               class="btn-premium">

                <span>View Details</span>

            </a>

        </div>

    </div>

</div>

<% } %>

</div>
        <% } %>
        <p class="fh-shop-foot"><a class="fh-link-accent" href="<%= ctx %>/home">Home</a></p>
    </div>
    
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

<script>

function removeWishlist(btn, productId){

    fetch("RemoveWishlistController?productId=" + productId)

    .then(() => {

        btn.closest(".product-card").remove();

    });
}

</script>

</body>
</html>
