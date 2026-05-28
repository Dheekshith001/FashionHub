<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Set your project context path variable here if needed, 
    // or keep empty if running from root.
    String ctx = request.getContextPath(); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed! | FashionHub</title>

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Google Fonts: Playfair Display & Poppins -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<link rel="stylesheet" href="<%=ctx%>/css/style.css">
<link rel="stylesheet" href="<%=ctx%>/css/nav-account.css">
</head>
<body class="loaded order-success-page">
<%@ include file="/WEB-INF/jspf/navbar.jspf" %>
   
    <!-- 1. Loading Screen -->
    <div id="loading-screen">
        <div class="fh-loader"></div>
        <div class="loader-text">FASHIONHUB</div>
    </div>

    <!-- 2. Confetti pieces (behind card) -->
    <div class="confetti"></div><div class="confetti"></div>
    <div class="confetti"></div><div class="confetti"></div>
    <div class="confetti"></div><div class="confetti"></div>
    <div class="confetti"></div><div class="confetti"></div>

    <!-- 3. Success Container -->
    <div class="success-container" id="main-content">
        <div class="success-card">
            
            <i class="fas fa-truck floating-truck"></i>

            <!-- Animated Tick Icon -->
            <div class="success-icon-wrap">
                <i class="fas fa-check success-tick"></i>
            </div>

            <h1 class="success-title">Order Placed Successfully!</h1>
            <p class="success-subtitle">Your fashion is on the way 🚚</p>

            <!-- Order Details -->
            <div class="order-details">
                <div class="detail-row">
                    <span class="detail-label">Expected Delivery</span>
                    <span class="detail-value">Within 7 Days</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Method</span>
                    <span class="detail-value">Cash On Delivery</span>
                </div>
            </div>

            <!-- Animated Tracking Steps -->
            <div class="order-tracking-wrap">
                <div class="tracking-steps">
                    <div class="tracking-steps-bar"></div>
                    
                    <div class="step active">
                        <div class="step-icon"><i class="fas fa-clipboard-check"></i></div>
                        <div class="step-text">Order<br>Confirmed</div>
                    </div>
                    <div class="step">
                        <div class="step-icon"><i class="fas fa-box"></i></div>
                        <div class="step-text">Packed</div>
                    </div>
                    <div class="step">
                        <div class="step-icon"><i class="fas fa-shipping-fast"></i></div>
                        <div class="step-text">Shipped</div>
                    </div>
                    <div class="step">
                        <div class="step-icon"><i class="fas fa-home"></i></div>
                        <div class="step-text">Out For<br>Delivery</div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-btns">
<a href="<%=ctx%>/OrdersController" class="btn btn-track">
                    <i class="fas fa-map-marker-alt"></i> Track Your Order
                </a>
                <a href="<%=ctx%>/home" class="btn btn-shop">
                    Continue Shopping
                </a>
            </div>

        </div>
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
    <!-- Minimal JS for loading and interaction -->
    <script>
        window.addEventListener('load', function() {
            // 1. Hide Loading Screen after 1.5 seconds simulating processing
            setTimeout(function() {
                const loader = document.getElementById('loading-screen');
                const content = document.getElementById('main-content');
                
                loader.classList.add('fade-out');
                content.classList.add('pop-in');
            }, 1500);
        });
    </script>

</body>
</html>