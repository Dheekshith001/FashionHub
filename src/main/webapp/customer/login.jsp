<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | FashionHub Secure Portal</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    
    <style>
        /* LUXURY SMOOTH ANIMATION */
        @keyframes interactiveSlideInLeft {
            0% { opacity: 0; transform: translateX(-150px) scale(0.95); }
            100% { opacity: 1; transform: translateX(0) scale(1); }
        }
        
        .login-container {
            animation: interactiveSlideInLeft 1.2s cubic-bezier(0.77, 0, 0.175, 1) forwards;
        }

        /* Staggered input animation for extra "Interactive" feel */
        .form-side > * {
            opacity: 0;
            animation: fadeInUp 0.8s ease forwards;
        }
        .form-side .header { animation-delay: 0.4s; }
        .form-side form { animation-delay: 0.6s; }
        .form-side .footer { animation-delay: 0.8s; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="home-page loaded">

    <!-- 1. MAIN HEADER (FIXED LAYOUT) -->
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

    <!-- CONTENT -->
    <div class="content-wrapper">
        <canvas id="particle-canvas"></canvas>
        <div class="login-container">
        
         
            <div class="login-card">
                <div class="split-container">
                    <!-- LOGIN: FORM LEFT -->
                    <div class="form-side">
                        <div class="header">
                            <h2>Unlock<br>Your Style</h2>
                            <p>Premium curation, modern elegance.</p>
                        </div>
                        <form action="<%= request.getContextPath() %>/LoginController" method="POST">
                            <div class="modern-input-group">
                                <input type="email" id="email" name="email" required>
                                <label for="email">Email Address</label>
                            </div>
                            <div class="label-row-modern"><a href="#" class="forgot-link">Forgot password?</a></div>
                            <div class="modern-input-group">
                                <input type="password" id="password" name="password" required>
                                <label for="password">Password</label>
                            </div>
                            <button type="submit" class="btn-login">Sign In <i class="fa fa-sign-in-alt" style="margin-left: 8px;"></i></button>
                        </form>
                        <div class="footer">
                            <p>First time here? <a href="${pageContext.request.contextPath}/customer/register.jsp">Create an Account</a></p>
                        </div>
                    </div>
                    <!-- LOGIN: BRANDING RIGHT -->
                    <div class="graphic-side">
                        <div class="vignette"></div>
                        <h3>ELEVATE<span><br>YOUR</span><br>STYLE</h3>
                        <p>Join over 50,000 enthusiasts choosing premium curated collections daily.</p>
                        <img src="${pageContext.request.contextPath}/images/logo.png" class="logo-img" alt="FH Logo">
                    </div>
                </div>
            </div>
            
            
            
        </div>
    </div>

    <!-- 10. DETAILED PROFESSIONAL FOOTER -->
    <footer class="footer">
        <div class="container footer-grid">
            <div class="footer-brand">
                <div class="logo logo-footer">FASHION<span>HUB</span></div>
                <p>Curating modern elegance through premium curated collections. Crafted for the modern era.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h4>Shop Categories</h4>
                <a href="#">Men's Clothing</a><a href="#">Women's Styles</a><a href="#">Kids Collection</a><a href="#">Premium Accessories</a><a href="#">Footwear Hub</a>
            </div>
            <div class="footer-col">
                <h4>Support & Help</h4>
                <a href="#">Contact Us</a><a href="#">Shipping Details</a><a href="#">Order Tracking</a><a href="#">Refund Policy</a><a href="#">FAQ's</a>
            </div>
            <div class="footer-col">
                <h4>Information</h4>
                <a href="#">About FashionHub</a><a href="#">Privacy Policy</a><a href="#">Terms & Conditions</a><a href="#">Sustainability</a><a href="#">Work with us</a>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="container footer-flex-bottom">
                <p>&copy; 2024 FashionHub. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Particle Background script (Keep your existing script here)
        const canvas = document.getElementById("particle-canvas");
        const ctx = canvas.getContext("2d");
        let particles = [];
        function resize() { canvas.width = window.innerWidth; canvas.height = window.innerHeight; }
        class Particle {
            constructor() {
                this.x = Math.random() * canvas.width; this.y = Math.random() * canvas.height;
                this.size = Math.random() * 2 + 1; this.speedX = Math.random() * 1 - 0.5; this.speedY = Math.random() * 1 - 0.5;
            }
            update() {
                this.x += this.speedX; this.y += this.speedY;
                if (this.x > canvas.width) this.x = 0; if (this.x < 0) this.x = canvas.width;
                if (this.y > canvas.height) this.y = 0; if (this.y < 0) this.y = canvas.height;
            }
            draw() { ctx.fillStyle = "rgba(255, 107, 26, 0.3)"; ctx.beginPath(); ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2); ctx.fill(); }
        }
        function init() { for(let i=0; i<70; i++) particles.push(new Particle()); }
        function animate() { ctx.clearRect(0,0,canvas.width,canvas.height); particles.forEach(p=>{p.update(); p.draw();}); requestAnimationFrame(animate); }
        window.addEventListener("resize", resize); resize(); init(); animate();
    </script>
</body>
</html>