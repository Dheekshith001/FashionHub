<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
    String fpError = (String) request.getAttribute("error");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | FashionHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Inter:wght@400;600;700&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/auth.css">
    <link rel="stylesheet" href="<%= ctx %>/css/forgotPassword.css">
</head>
<body class="home-page loaded auth-portal">

    <div class="auth-cinematic" aria-hidden="true">
        <div class="auth-cinematic__base"></div>
        <div class="auth-cinematic__sheen"></div>
        <div class="auth-cinematic__blob auth-cinematic__blob--1"></div>
        <div class="auth-cinematic__blob auth-cinematic__blob--2"></div>
        <div class="auth-cinematic__blob auth-cinematic__blob--3"></div>
        <div class="auth-cinematic__grain"></div>
    </div>
    <canvas id="auth-particle-canvas" class="auth-particle-canvas" aria-hidden="true"></canvas>
    <header class="main-header show">
        <div class="container navbar-top">
            <div class="nav-left">
                <a href="${pageContext.request.contextPath}/home.jsp" class="logo">
                    <img src="${pageContext.request.contextPath}/images/logo.png" class="logo-img" alt="FashionHub Logo">
                    FASHION<span>HUB</span>
                </a>
            </div>
            <div class="nav-center">
                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/home.jsp" class="nav-link active">HOME</a>
                    <a href="#" class="nav-link">MEN</a>
                    <a href="#" class="nav-link">WOMEN</a>
                    <a href="#" class="nav-link">KIDS</a>
                    <a href="#" class="nav-link">FOOTWEAR</a>
                    <a href="#" class="nav-link">ACCESSORIES</a>
                    <a href="#" class="nav-link">BEAUTY</a>
                </div>
            </div>
            <div class="search-box">
                <input type="text" placeholder="Search...">
                <button class="search-toggle"><i class="fa fa-search"></i></button>
            </div>
            <div class="nav-right">
                <button class="icon-btn" title="Wishlist"><i class="far fa-heart"></i></button>
                <div class="nav-item">
                    <button class="icon-btn" title="Cart"><i class="fa fa-shopping-cart"></i></button>
                    <span class="badge">0</span>
                </div>
                <button class="icon-btn" title="Account"><i class="far fa-user"></i></button>
            </div>
        </div>
    </header>

    <main class="auth-main">
        <div class="auth-main__inner container">
            <% if (fpError != null) { %>
            <div class="auth-flash auth-flash--error" role="alert"><i class="fas fa-circle-exclamation"></i> <%= fpError %></div>
            <% } %>

            <div class="auth-card fp-card">
                <div class="fp-inner">
                    <header class="auth-pane__head">
                        <p class="auth-pane__eyebrow">Account recovery</p>
                        <h1 class="auth-pane__title">Reset your password</h1>
                        <p class="auth-pane__sub">Enter the email on your account and choose a new password.</p>
                    </header>

                    <form class="fp-form" action="<%= ctx %>/ForgotPasswordController" method="POST" autocomplete="on">
                        <div class="auth-field">
                            <input type="email" id="fp-email" name="email" placeholder=" " required autocomplete="email">
                            <label for="fp-email">Email</label>
                            <span class="auth-field__ring" aria-hidden="true"></span>
                        </div>
                        <div class="auth-field fp-password-wrap">
                            <input type="password" id="fp-new" name="newPassword" placeholder=" " required autocomplete="new-password">
                            <label for="fp-new">New password</label>
                            <span class="auth-field__ring" aria-hidden="true"></span>
                            <button type="button" class="fp-toggle" id="fpToggle1" aria-label="Show password"><i class="far fa-eye"></i></button>
                        </div>
                        <div class="auth-field fp-password-wrap">
                            <input type="password" id="fp-confirm" name="confirmPassword" placeholder=" " required autocomplete="new-password">
                            <label for="fp-confirm">Confirm password</label>
                            <span class="auth-field__ring" aria-hidden="true"></span>
                            <button type="button" class="fp-toggle" id="fpToggle2" aria-label="Show password"><i class="far fa-eye"></i></button>
                        </div>

                        <button type="submit" class="auth-submit"><span>Update password</span><i class="fas fa-check"></i></button>
                    </form>

                    <p class="fp-back"><a class="auth-text-link" href="<%= ctx %>/customer/auth.jsp">Back to sign in</a></p>
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
    <script src="<%= ctx %>/js/auth.js" defer></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            function bindToggle(btnId, inputId) {
                var btn = document.getElementById(btnId);
                var input = document.getElementById(inputId);
                if (!btn || !input) return;
                btn.addEventListener('click', function () {
                    var show = input.type === 'password';
                    input.type = show ? 'text' : 'password';
                    btn.innerHTML = show ? '<i class="far fa-eye-slash"></i>' : '<i class="far fa-eye"></i>';
                });
            }
            bindToggle('fpToggle1', 'fp-new');
            bindToggle('fpToggle2', 'fp-confirm');
        });
    </script>
</body>
</html>
