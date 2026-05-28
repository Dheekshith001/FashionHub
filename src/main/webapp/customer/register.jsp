<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | FashionHub Secure Portal</title>
    
    <!-- 1. Include Global Fonts and Icons (Required) -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Using same logic as login to ensure exact matching -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        /* =========================================================
           UNIFIED LAYOUT CSS (Matches Login Exactly)
           ========================================================= */
        :root {
            --orange: #ff6b1a;
            --dark: #1a1c22;
        }

        /* Forces the page to handle header/footer correctly */
        body {
            display: flex !important;
            flex-direction: column !important;
            min-height: 100vh !important;
            padding: 0 !important;
            margin: 0 !important;
            background-color: #f4f7f6 !important;
            overflow-x: hidden;
        }

        /* Push footer to bottom */
        .content-wrapper {
            flex-grow: 1;
            position: relative;
            padding-top: 100px;
            padding-bottom: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%);
            z-index: 1;
        }

        #particle-canvas {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; opacity: 0.3;
        }

        /* Interactive Directional Animation */
        @keyframes smoothSlideFromRight {
            0% { opacity: 0; transform: translateX(150px) scale(0.95); }
            100% { opacity: 1; transform: translateX(0) scale(1); }
        }

        .registration-container {
            width: 90%;
            max-width: 1100px;
            animation: smoothSlideFromRight 1.2s cubic-bezier(0.77, 0, 0.175, 1) forwards;
        }

        .registration-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            display: flex;
            min-height: 700px;
        }

        /* Swapped Layout: Branding LEFT, Form RIGHT */
        .split-container { display: flex; width: 100%; min-height: 700px; }

        .graphic-side {
            flex: 1;
            background: linear-gradient(135deg, #1a1c22 0%, #2c3e50 100%);
            display: flex; flex-direction: column; justify-content: center; align-items: center;
            color: #fff; padding: 40px; text-align: center; position: relative;
        }

        .graphic-side .vignette { position: absolute; inset: 0; background: radial-gradient(circle, transparent 40%, rgba(0,0,0,0.3) 100%); z-index: 1; }

        .graphic-side h3 {
            font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 900; line-height: 1.1; margin-bottom: 20px; text-transform: uppercase; z-index: 2;
        }
        .graphic-side h3 span { color: var(--orange); }
        .graphic-side p { color: #bdc3c7; font-size: 16px; max-width: 300px; z-index: 2; line-height: 1.6; }
        .graphic-side .logo-img-big { width: 80px; margin-top: 20px; opacity: 0.8; z-index: 2; }

        .form-side {
            flex: 1.2;
            padding: 50px 60px;
            display: flex; flex-direction: column; justify-content: center;
            background: #fff;
        }

        .form-side .header { margin-bottom: 30px; }
        .form-side .header h2 { font-family: 'Playfair Display', serif; font-size: 32px; font-weight: 900; }
        .form-side .header p { color: #7f8c8d; font-size: 14px; }

        /* Floating Label Logic */
        .modern-input-group { position: relative; margin-bottom: 25px; }
        .modern-input-group input {
            width: 100%; padding: 15px 5px; font-family: 'Inter', sans-serif; font-size: 16px; border: none; border-bottom: 2px solid #eee; background: transparent; outline: none; transition: 0.3s;
        }
        .modern-input-group label {
            position: absolute; top: 15px; left: 5px; color: #999; pointer-events: none; transition: 0.3s;
        }
        .modern-input-group input:focus ~ label, .modern-input-group input:valid ~ label {
            top: -12px; font-size: 12px; color: var(--orange); font-weight: 700;
        }
        .modern-input-group input:focus { border-color: var(--orange); }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-row-triple { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; }

        .btn-register {
            background: linear-gradient(to right, var(--orange), #ff4d4d);
            border: none; color: #fff; padding: 15px; border-radius: 30px; font-weight: 800; text-transform: uppercase; cursor: pointer; transition: 0.3s; margin-top: 10px;
            box-shadow: 0 4px 15px rgba(255, 107, 26, 0.3);
        }
        .btn-register:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(255, 107, 26, 0.5); }
    </style>
</head>
<body class="home-page loaded">

    <!-- =========================================================
         1. MAIN HEADER (Exactly matching Login)
         ========================================================= -->
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
                    <a href="${pageContext.request.contextPath}/home.jsp" class="nav-link">HOME</a>
                    <a href="#" class="nav-link">MEN</a><a href="#" class="nav-link">WOMEN</a><a href="#" class="nav-link">KIDS</a>
                    <a href="#" class="nav-link">FOOTWEAR</a><a href="#" class="nav-link">ACCESSORIES</a><a href="#" class="nav-link">BEAUTY</a>
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

    <!-- 2. CONTENT AREA -->
    <div class="content-wrapper">
        <canvas id="particle-canvas"></canvas>
        <div class="registration-container"> 
            <div class="registration-card">
                <div class="split-container">
                    
                    <!-- LEFT SIDE: BRANDING (Swapped) -->
                    <div class="graphic-side">
                        <div class="vignette"></div>
                        <h3>ELEVATE<span><br>YOUR</span><br>STYLE</h3>
                        <p>Join over 50,000 enthusiasts choosing premium curated collections daily.</p>
                        <img src="${pageContext.request.contextPath}/images/logo.png" class="logo-img-big" alt="FH Logo">
                    </div>

                    <!-- RIGHT SIDE: FORM -->
                    <div class="form-side">
                        <div class="header">
                            <h2>Join Us</h2>
                            <p>Create your FashionHub account today.</p>
                        </div>
                        <form action="<%= request.getContextPath() %>/RegisterController" method="POST">
                            <div class="modern-input-group">
                                <input type="text" name="name" required>
                                <label>Full Name</label>
                            </div>
                            <div class="form-row">
                                <div class="modern-input-group"><input type="email" name="email" required><label>Email Address</label></div>
                                <div class="modern-input-group"><input type="password" name="password" required><label>Password</label></div>
                            </div>
                            <div class="form-row">
                                <div class="modern-input-group"><input type="tel" name="phone" required><label>Phone</label></div>
                                <div class="modern-input-group"><input type="date" name="dob" required><label style="top:-12px; font-size:12px; color:var(--orange);">DOB</label></div>
                            </div>
                            <div class="modern-input-group"><input type="text" name="address" required><label>Full Address</label></div>
                            <div class="form-row-triple">
                                <div class="modern-input-group"><input type="text" name="city" required><label>City</label></div>
                                <div class="modern-input-group"><input type="text" name="state" required><label>State</label></div>
                                <div class="modern-input-group"><input type="text" name="pincode" required><label>Pincode</label></div>
                            </div>
                            <button type="submit" class="btn-register">Register Now <i class="fa fa-user-plus" style="margin-left:8px;"></i></button>
                        </form>
                        <div style="text-align:center; margin-top:25px;">
                            <p style="color:#7f8c8d; font-size:14px;">Already have an account? <a href="${pageContext.request.contextPath}/customer/auth.jsp" style="color:var(--orange); font-weight:700; text-decoration:none;">Sign In Here</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- =========================================================
         3. FOOTER (Exact Match from Login)
         ========================================================= -->
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

    <!-- 4. SCRIPTS (Particles Logic) -->
    <script>
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