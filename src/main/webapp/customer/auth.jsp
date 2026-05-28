<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.fashionhub.util.AuthUtil"%>
<%
    String authError = (String) request.getAttribute("error");
    String authSuccess = (String) request.getAttribute("success");
    String authNotice = (String) session.getAttribute(AuthUtil.SESSION_AUTH_NOTICE);
    if (authNotice != null) {
        session.removeAttribute(AuthUtil.SESSION_AUTH_NOTICE);
    }
    String authFlashSuccess = (String) session.getAttribute(AuthUtil.SESSION_AUTH_SUCCESS);
    if (authFlashSuccess != null) {
        session.removeAttribute(AuthUtil.SESSION_AUTH_SUCCESS);
    }
    if (authSuccess == null && authFlashSuccess != null) {
        authSuccess = authFlashSuccess;
    }
    String returnUrl = request.getParameter("return");
    if (returnUrl == null) {
        returnUrl = "";
    }
    String authOpenTab = (String) request.getAttribute("authOpenTab");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign In &amp; Register | FashionHub</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/nav-account.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/auth.css">
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
	<canvas id="auth-particle-canvas" class="auth-particle-canvas"
		aria-hidden="true"></canvas>

	<%@ include file="/WEB-INF/jspf/navbar.jspf"%>

	<main class="auth-main">
		<div class="auth-main__inner container">

			<% if (authNotice != null) { %>
			<div class="auth-flash auth-flash--notice" role="status">
				<i class="fas fa-lock"></i>
				<%= authNotice %></div>
			<% } %>
			<% if (authError != null) { %>
			<div class="auth-flash auth-flash--error" role="alert">
				<i class="fas fa-circle-exclamation"></i>
				<%= authError %></div>
			<% } %>
			<% if (authSuccess != null) { %>
			<div class="auth-flash auth-flash--success" role="status">
				<i class="fas fa-circle-check"></i>
				<%= authSuccess %></div>
			<% } %>

			<div class="auth-card" id="authCard" data-mode="login"
				data-active-pane="login"
				data-initial-auth-tab="<%= "register".equals(authOpenTab) ? "register" : "login" %>">
				<div class="auth-card__layout">

					<div class="auth-card__forms">
						<div class="auth-forms-viewport">
							<div class="auth-forms-track">
								<form class="auth-pane auth-pane--login"
									action="<%= request.getContextPath() %>/LoginController"
									method="POST">
									<div class="auth-pane__surface">
										<header class="auth-pane__head">
											<p class="auth-pane__eyebrow">Member access</p>
											<h1 class="auth-pane__title">Welcome Back</h1>
											<p class="auth-pane__sub">Sign in to continue your
												premium fashion journey.</p>
										</header>

										<input type="hidden" name="returnUrl"
											value="<%= AuthUtil.htmlEscapeAttr(returnUrl) %>">

										<div class="auth-field">
											<input type="email" id="login-email" name="email"
												placeholder=" " autocomplete="email" required> <label
												for="login-email">Email</label> <span
												class="auth-field__ring" aria-hidden="true"></span>
										</div>
										<div class="auth-field">
											<input type="password" id="login-password" name="password"
												placeholder=" " autocomplete="current-password" required>
											<label for="login-password">Password</label> <span
												class="auth-field__ring" aria-hidden="true"></span>
										</div>

										<div class="auth-forgot-row">
											<a class="auth-text-link"
												href="${pageContext.request.contextPath}/ForgotPasswordController">Forgot
												Password?</a>
										</div>

										<button type="submit" class="auth-submit">
											<span>Sign In</span> <i class="fas fa-arrow-right"></i>
										</button>

										<p class="auth-inline-cta">
											New to FashionHub?
											<button type="button" class="auth-inline-cta__btn"
												data-auth-show="register">Create Account</button>
										</p>
									</div>
								</form>

								<form class="auth-pane auth-pane--register" id="registerForm"
									action="<%= request.getContextPath() %>/RegisterController"
									method="POST">
									<input type="hidden" name="gender" value="Unspecified">
								
								
								

									<div class="auth-pane__surface auth-pane__surface--scroll">
										<header class="auth-pane__head">
											<p class="auth-pane__eyebrow">New member</p>
											<h1 class="auth-pane__title">Create Your Profile</h1>
											<p class="auth-pane__sub">Unlock curated edits, early
												drops, and personalized fashion.</p>
										</header>

										<div class="auth-field">
											<input type="text" id="reg-name" name="name" placeholder=" "
												autocomplete="name" required> <label for="reg-name">Full
												Name</label> <span class="auth-field__ring" aria-hidden="true"></span>
										</div>
										<div class="auth-field-grid auth-field-grid--2">
											<div class="auth-field">
												<input type="email" id="reg-email" name="email"
													placeholder=" " autocomplete="email" required> <label
													for="reg-email">Email</label> <span
													class="auth-field__ring" aria-hidden="true"></span>
											</div>
											<div class="auth-field">
												<input type="password" id="reg-password" name="password"
													placeholder=" " autocomplete="new-password" required>
												<label for="reg-password">Password</label> <span
													class="auth-field__ring" aria-hidden="true"></span>
											</div>
										</div>
										<div class="auth-field">
											<input type="tel" id="reg-phone" name="phone" placeholder=" "
												autocomplete="tel" required> <label for="reg-phone">Phone</label>
											<span class="auth-field__ring" aria-hidden="true"></span>
										</div>
										<div class="auth-field">
											<input type="text" id="reg-address" name="address"
												placeholder=" " required> <label for="reg-address">Address</label>

											<span class="auth-field__ring" aria-hidden="true"></span>
										</div>
										<div class="auth-field-grid auth-field-grid--3">
											<div class="auth-field">
												<input type="text" id="reg-city" name="city" placeholder=" "
													autocomplete="address-level2" required> <label
													for="reg-city">City</label> <span class="auth-field__ring"
													aria-hidden="true"></span>
											</div>
											<div class="auth-field">
												<input type="text" id="reg-state" name="state"
													placeholder=" " autocomplete="address-level1" required>
												<label for="reg-state">State</label> <span
													class="auth-field__ring" aria-hidden="true"></span>
											</div>
											<div class="auth-field">
												<input type="text" id="reg-pincode" name="pincode"
													placeholder=" " inputmode="numeric"
													autocomplete="postal-code" required> <label
													for="reg-pincode">Pincode</label> <span
													class="auth-field__ring" aria-hidden="true"></span>
											</div>
										</div>

										<button type="submit" class="auth-submit">
											<span>Register</span> <i class="fas fa-user-plus"></i>
										</button>

										<p class="auth-inline-cta">
											Already a member?
											<button type="button" class="auth-inline-cta__btn"
												data-auth-show="login">Sign In Here</button>
										</p>
									</div>
								</form>
							</div>
						</div>
					</div>

					<div class="auth-card__showcase">
						<div class="auth-showcase">
							<div class="auth-showcase__gradient-shift" aria-hidden="true"></div>
							<div class="auth-showcase__blob auth-showcase__blob--a"
								aria-hidden="true"></div>
							<div class="auth-showcase__blob auth-showcase__blob--b"
								aria-hidden="true"></div>
							<div class="auth-showcase__blob auth-showcase__blob--c"
								aria-hidden="true"></div>
							<div class="auth-showcase__shine" aria-hidden="true"></div>

							<div class="auth-showcase__face auth-showcase__face--login">
								<div class="auth-showcase__brand">
									<div class="auth-showcase__logo-ring">
										<img src="${pageContext.request.contextPath}/images/logo.png"
											class="auth-showcase__logo" alt="FashionHub">
									</div>
								</div>
								<p class="auth-showcase__kicker">FashionHub</p>
								<h2 class="auth-showcase__headline">Your world of style
									starts here.</h2>
								<p class="auth-showcase__lede">Premium edits, member
									exclusives, and a storefront built for modern luxury.</p>
								<button type="button" class="auth-showcase__btn"
									data-auth-show="register">
									<span>Create Account</span> <i class="fas fa-chevron-right"></i>
								</button>
							</div>

							<div class="auth-showcase__face auth-showcase__face--register">
								<div class="auth-showcase__brand">
									<div class="auth-showcase__logo-ring">
										<img src="${pageContext.request.contextPath}/images/logo.png"
											class="auth-showcase__logo" alt="FashionHub">
									</div>
								</div>
								<p class="auth-showcase__kicker">FashionHub</p>
								<h2 class="auth-showcase__headline">Join the FashionHub
									experience.</h2>
								<p class="auth-showcase__lede">Create your profile and step
									into curated collections and early access drops.</p>
								<button type="button"
									class="auth-showcase__btn auth-showcase__btn--alt"
									data-auth-show="login">
									<span>Sign In Here</span> <i class="fas fa-arrow-left"></i>
								</button>
							</div>
						</div>
					</div>

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
				<p>&copy; 2026 FashionHub. All Rights Reserved.</p>
			</div>
		</div>
	</footer>

	<script src="${pageContext.request.contextPath}/js/auth.js" defer></script>
</body>
</html>
