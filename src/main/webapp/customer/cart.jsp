<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fashionhub.model.CartLineItem"%>
<%@ page import="com.fashionhub.model.Product"%>
<%
    @SuppressWarnings("unchecked")
    ArrayList<CartLineItem> cartLines = (ArrayList<CartLineItem>) request.getAttribute("cartLines");
    if (cartLines == null) {
        cartLines = new ArrayList<>();
    }
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Bag | FashionHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/nav-account.css">
</head>
<body class="home-page loaded fh-shop-page">
<%@ include file="/WEB-INF/jspf/navbar.jspf" %>
  <div class="fh-shop-wrap">

    <h1 class="fh-shop-head">Your bag</h1>

    <% if (cartLines.isEmpty()) { %>

        <div class="fh-shop-card">

            <p class="fh-empty">Your bag is empty.</p>

            <a class="fh-link-accent"
               href="<%= ctx %>/ProductController">
               Continue shopping
            </a>

        </div>

    <% } else { %>

    <%
        double total = 0;

        for(CartLineItem line : cartLines){

            Product p = line.getProduct();

            total += p.getPrice() * line.getCart().getQuantity();
        }
    %>

    <div class="cart-layout">

        <!-- LEFT SIDE PRODUCTS -->

        <div class="cart-products">

            <% for (CartLineItem line : cartLines) {

                Product p = line.getProduct();

                if (p == null) continue;
            %>

            <div class="fh-cart-row">

                <img src="<%= p.getImage() %>"
                     alt="<%= p.getName() %>">

                <div class="cart-info">

                    <strong><%= p.getName() %></strong>

                    <span class="fh-cart-meta">
                        Size: <%= line.getCart().getSize() %>
                    </span>

                    <span class="price-text fh-cart-price">
                        ₹<%= String.format("%.2f", p.getPrice()) %>
                    </span>

                </div>

               <form class="fh-cart-actions"
      method="post"
      action="<%= ctx %>/UpdateCartController">

    <input type="hidden"
           name="cartId"
           value="<%= line.getCart().getCartId() %>">

    <div class="qty-box">

        <button type="button"
                class="qty-btn"
                onclick="changeQty(this,-1)">
            -
        </button>

        <input type="number"
               name="qty"
               min="1"
               value="<%= line.getCart().getQuantity() %>"
               readonly>

        <button type="button"
                class="qty-btn"
                onclick="changeQty(this,1)">
            +
        </button>

    </div>

    <button type="submit"
            class="fh-btn-line fh-btn-line--primary">
        Update
    </button>

</form>

                <a class="fh-btn-line fh-btn-line--ghost"
                   href="<%= ctx %>/RemoveCartController?id=<%= line.getCart().getCartId() %>">
                    Remove
                </a>

            </div>

            <% } %>

        </div>

        <!-- RIGHT SIDE SUMMARY -->

        <div class="order-summary">

            <h3>Price Details</h3>

            <div class="summary-row">
                <span>Total Items</span>
                <span><%= cartLines.size() %></span>
            </div>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹<%= String.format("%.2f", total) %></span>
            </div>

            <div class="summary-row">
                <span>Delivery</span>
                <span style="color:green;">FREE</span>
            </div>

            <hr>

            <div class="summary-row total">
                <span>Total Amount</span>
                <span>₹<%= String.format("%.2f", total) %></span>
            </div>

            <a href="<%= ctx %>/CheckoutController"
               class="checkout-btn">

               Proceed To Checkout

            </a>

        </div>

    </div>

    <% } %>

    <p class="fh-shop-foot">

        <a class="fh-link-accent"
           href="<%= ctx %>/home">

           Back to home

        </a>

    </p>

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

function changeQty(btn,change){

    let input = btn.parentElement.querySelector("input");

    let value = parseInt(input.value);

    value += change;

    if(value < 1){

        value = 1;
    }

    input.value = value;
}

</script>

</body>
</html>
