<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%
    String ctx = request.getContextPath();
    String checkoutError = (String) request.getAttribute("checkoutError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout | FashionHub</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Inter:wght@400;600;700&family=Playfair+Display:wght@700;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%= ctx %>/css/style.css">
<link rel="stylesheet" href="<%= ctx %>/css/nav-account.css">
</head>
<body class="home-page loaded fh-shop-page">

	<%@ include file="/WEB-INF/jspf/navbar.jspf"%>

	<main class="fh-shop-wrap">

		<h1 class="fh-shop-head">Secure Checkout</h1>

		<% if (checkoutError != null) { %>

		<div class="fh-co-err" role="alert">
			<i class="fas fa-circle-exclamation"></i>
			<%= checkoutError %>
		</div>

		<% } %>

		<div class="checkout-layout">

			<!-- LEFT SIDE -->

			<div class="checkout-left">

				<!-- ADDRESS -->

				<div class="checkout-card">

					<h2>
						<i class="fa-solid fa-location-dot"></i> Delivery Address
					</h2>

					<div class="address-box">

						<p>
							<strong>${checkoutUser.name}</strong>
						</p>

						<p>${checkoutUser.phone}</p>

						<p>${checkoutUser.address}</p>

					</div>

					<a href="<%= ctx %>/ProfileController" class="edit-profile-btn">

						Edit Profile </a>

				</div>

				<!-- PAYMENT -->

				<div class="checkout-card">

					<h2>
						<i class="fa-solid fa-credit-card"></i> Payment Method
					</h2>

					<div class="payment-options">

						<!-- COD ENABLED -->

						<label class="payment-option active-payment"> <input
							type="radio" name="payment" checked> <span>Cash On
								Delivery</span> <small>Pay when your order arrives</small>

						</label>

						<!-- UPI DISABLED -->

						<label class="payment-option disabled-payment"> <input
							type="radio" disabled> <span>UPI Payment</span> <small>Coming
								Soon</small>

						</label>

						<!-- CARD DISABLED -->

						<label class="payment-option disabled-payment"> <input
							type="radio" disabled> <span>Credit / Debit Card</span> <small>Coming
								Soon</small>

						</label>

					</div>

				</div>

				<!-- DELIVERY BENEFITS -->

				<div class="checkout-card">

					<h2>
						<i class="fa-solid fa-truck"></i> Delivery Benefits
					</h2>

					<div class="benefits">

						<p>✔ Free Delivery</p>

						<p>✔ Easy Returns</p>

						<p>✔ Secure Payment</p>

						<p>✔ Delivery within 7 days</p>

					</div>

				</div>

			</div>

			<!-- RIGHT SIDE -->

			<div class="checkout-right">

				<div class="summary-card">

					<h2>Price Details</h2>
					<div class="summary-row">
						<span>Items Total</span> <span>₹${subtotal}</span>
					</div>

					<div class="summary-row">
						<span>Delivery</span> <span style="color: green;">FREE</span>
					</div>

					<div class="summary-row">
						<span>Platform Fee</span> <span>₹10</span>
					</div>

					<hr>

					<div class="summary-total">

						<span>Total Amount</span> <span>₹${totalAmount}</span>

					</div>

					<form method="post" action="<%= ctx %>/CheckoutController"
						id="placeOrderForm">
						<button type="submit" class="place-order-btn" id="placeOrderBtn">

							<i class="fas fa-lock"></i> PLACE ORDER

						</button>

					</form>

					<a class="back-cart-link" href="<%= ctx %>/ViewCartController">

						Back To Bag </a>

				</div>

			</div>

		</div>

	</main>

	<footer class="footer">
		<div class="container footer-grid">
			<div class="footer-brand">
				<div class="logo logo-footer">
					FASHION<span>HUB</span>
				</div>
				<p>Curating modern elegance through premium curated collections.
					Crafted for the modern era.</p>
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
