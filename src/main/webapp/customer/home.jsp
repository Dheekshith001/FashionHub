<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fashionhub.dao.ProductDAO"%>
<%@ page import="com.fashionhub.model.Product"%>

<%
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
    if (products == null) products = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FashionHub | Premium Style</title>
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- CSS -->

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/nav-account.css">
</head>
<body class="home-page">

	<!-- 1. MAIN HEADER -->
	<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

	

	<!-- 3. HERO SLIDER SECTION -->
	<section class="hero-slider-section">

    <div class="slider">

        <!-- SLIDE 1 -->
        <div class="slide active">

            <img src="${pageContext.request.contextPath}/images/hero.png"
                 alt="Hero 1">

            <div class="overlay">

                <h1>
                    DON’T FOLLOW<br>
                    <span>LEAD.</span>
                </h1>

                <p>
                    Your style. Your rules.
                </p>

                <a href="#filter"
   class="slider-btn">

                    Shop Now →

                </a>

            </div>

        </div>

        <!-- SLIDE 2 -->
        <div class="slide">

            <img src="${pageContext.request.contextPath}/images/hero2.png"
                 alt="Hero 2">

            <div class="overlay">

                <h1>
                    NEW SEASON<br>
                    <span>COLLECTION</span>
                </h1>

                <p>
                    Fresh looks for every moment.
                </p>

               <a href="#filter"
   class="slider-btn">

                    Shop Now →

                </a>

            </div>

        </div>

        <!-- SLIDE 3 -->
        <div class="slide">

            <img src="${pageContext.request.contextPath}/images/hero3.png"
                 alt="Hero 3">

            <div class="overlay">

                <h1>
                    STYLE THAT<br>
                    <span>STANDS OUT</span>
                </h1>

                <p>
                    Upgrade your wardrobe today.
                </p>

                <a href="#filter"
   class="slider-btn">

                    Shop Now →

                </a>

            </div>

        </div>

    </div>

</section>
	<!-- 4. TOP BRANDS (Endless Loop + Buttons) -->
	<section class="brands-section section-padding">
		<div class="container">
			<h2 class="centered-header">
				<i class="fa-solid fa-star title-orange"></i> <span
					class="title-dark">TOP</span> <span class="title-orange">BRANDS</span>
				<i class="fa-solid fa-star title-orange"></i>
			</h2>
<div class="brands-wrapper contained-scroll">

    <div class="brands-track">

        <!-- HIGHLANDER -->
        <a href="${pageContext.request.contextPath}/CategoryController?brand=HIGHLANDER"
           class="brand-pill">
            <span>HIGHLANDER</span>
        </a>

        <!-- H&M -->
        <a href="${pageContext.request.contextPath}/CategoryController?brand=JUMPLITE"
           class="brand-pill brand-pill--muted">
            <span>JUMPLITE</span>
        </a>

        <!-- WROGN -->
        <a href="${pageContext.request.contextPath}/CategoryController?brand=WROGN"
           class="brand-pill">
            <span>WROGN</span>
        </a>

        <!-- LEVI'S -->
        <a href="${pageContext.request.contextPath}/CategoryController?brand=LEVIS"
           class="brand-pill brand-pill--muted">
            <span>LEVI'S</span>
        </a>

        <!-- NIKE -->
        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=JUMPLITE"
           class="brand-pill">
            <span>JUMPLITE</span>
        </a>

        <!-- PUMA -->
        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=PUMA"
           class="brand-pill">
            <span>PUMA</span>
        </a>

        <!-- ADIDAS -->
        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=ADIDAS"
           class="brand-pill">
            <span>ADIDAS</span>
        </a>

        <!-- Duplicate Set -->

        <a href="${pageContext.request.contextPath}/CategoryController?brand=HIGHLANDER"
           class="brand-pill">
            <span>HIGHLANDER</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?brand=SOJANYA"
           class="brand-pill brand-pill--muted">
            <span>SOJANYA</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?brand=WROGN"
           class="brand-pill">
            <span>WROGN</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?brand=ROADSTER"
           class="brand-pill brand-pill--muted">
            <span>Roadster</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=KISAH"
           class="brand-pill">
            <span>KISAH</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=PUMA"
           class="brand-pill">
            <span>PUMA</span>
        </a>

        <a href="${pageContext.request.contextPath}/CategoryController?category=4&brand=ADIDAS"
           class="brand-pill">
            <span>ADIDAS</span>
        </a>

    </div>

</div>


		</div>
	</section>

<!-- 5. NEW ARRIVALS -->
<section class="section-new-arrivals section-padding">
    <div class="container">
        <h2 class="centered-header">
            <i class="fa-solid fa-wand-magic-sparkles title-orange"></i> 
            <span class="title-dark">NEW</span> 
            <span class="title-orange">ARRIVALS</span>
            <i class="fa-solid fa-wand-magic-sparkles title-orange"></i>
        </h2>

        <div class="product-grid">
            <% for(int i=0; i < Math.min(products.size(), 4); i++) { 
                Product p = products.get(i); %>

            <div class="product-card">
                <div class="card-header bg-pale">

                    <!-- 🔥 NEW BADGE (ADDED) -->
                    <span class="badge-new">NEW</span>

                  <button class="wishlist-btn-card"
        onclick="toggleWishlist(this, <%= p.getProductId() %>)">

    <i class="far fa-heart"></i>

</button>

                    <img src="<%= p.getImage() %>" 
                         class="product-img" 
                         alt="<%= p.getName() %>">
                </div>

                <div class="card-body">
                    <h3><%= p.getName() %></h3>


  <div class="stars">
    <% 
        double r = p.getRating(); 
        int fullStars = (int) r;
        boolean hasHalf = (r - fullStars) >= 0.5;
    %>

    <% for(int s = 1; s <= 5; s++) { %>

        <% if(s <= fullStars) { %>
            <i class="fa fa-star"></i>

        <% } else if(s == fullStars + 1 && hasHalf) { %>
            <i class="fa fa-star-half-alt"></i>

        <% } else { %>
            <i class="far fa-star"></i>

        <% } %>

    <% } %>

    <span class="rating-num">
        (<%= String.format("%.1f", r) %>)
    </span>
</div>
                    <div class="price-action">
                        <span class="price-text">₹<%= p.getPrice() %></span>

                        <a href="ProductController?id=<%= p.getProductId() %>"
                           class="btn-premium">
                           <span>View Details</span>
                        </a>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </div>
</section>

	<!-- 6. TOP SELLING (Endless Loop) -->
	<section class="section-top-selling section-padding">
		<div class="container">
			<h2 class="centered-header">
				<i class="fa-solid fa-fire title-orange"></i> <span
					class="title-dark">TOP</span> <span class="title-orange">SELLING</span>
				<i class="fa-solid fa-fire title-orange"></i>
			</h2>
			<div class="scrolling-wrapper contained-scroll">
				<div class="scrolling-track">
					<%-- Loop contents twice for seamless transition --%>
					<% for(int loop=0; loop<2; loop++) { %>
					<% for(int i=4; i < Math.min(products.size(), 14); i++) { Product p = products.get(i); %>
					<div class="product-card scroll-card">
						<div class="card-header">
							<button class="wishlist-btn-card"
        onclick="toggleWishlist(this, <%= p.getProductId() %>)">

    <i class="far fa-heart"></i>

</button>
							<img src="<%= p.getImage() %>" class="product-img" alt="<%= p.getName() %>">
						</div>
						<div class="card-body">
							<h3><%= p.getName() %></h3>
							
							<div class="stars">
    <% 
        double r = p.getRating(); 
        int fullStars = (int) r;
        boolean hasHalf = (r - fullStars) >= 0.5;
    %>

    <% for(int s = 1; s <= 5; s++) { %>

        <% if(s <= fullStars) { %>
            <i class="fa fa-star"></i>

        <% } else if(s == fullStars + 1 && hasHalf) { %>
            <i class="fa fa-star-half-alt"></i>

        <% } else { %>
            <i class="far fa-star"></i>

        <% } %>

    <% } %>

    <span class="rating-num">
        (<%= String.format("%.1f", r) %>)
    </span>
</div>
						
						
							<div class="price-action">
								<span class="price-text">₹<%= p.getPrice() %></span> <a
									href="ProductController?id=<%= p.getProductId() %>"
									class="btn-premium"><span>View Details</span></a>
							</div>
						</div>
					</div>
					<% } %>
					<% } %>
				</div>
			</div>
		</div>
	</section>
<!-- 7. FILTER BAR -->
<div class="sticky-filter-wrapper">

    <div class="container filter-flex">

        <!-- CATEGORY -->
        <div class="dropdown">

            <button class="btn-category-main" type="button">

                <span id="categoryText">CATEGORY</span>

                <i class="fa fa-chevron-down"></i>

            </button>

            <div class="dropdown-menu">

                <button type="button"
                        onclick="filterProducts('Men')">
                    Men
                </button>

                <button type="button"
                        onclick="filterProducts('Women')">
                    Women
                </button>

                <button type="button"
                        onclick="filterProducts('Kids')">
                    Kids
                </button>

                <button type="button"
                        onclick="filterProducts('Footwear')">
                    Footwear
                </button>

                <button type="button"
                        onclick="filterProducts('Accessories')">
                    Accessories
                </button>

                <button type="button"
                        onclick="filterProducts('Beauty')">
                    Beauty
                </button>

            </div>

        </div>

        <!-- PRICE BUTTONS -->
        <div class="filter-buttons" id="filter">

            <button class="btn-premium filter-btn"
                    type="button"
                    onclick="filterPrice(100)">
                <span>Under 100</span>
            </button>

            <button class="btn-premium filter-btn"
                    type="button"
                    onclick="filterPrice(300)">
                <span>Under 300</span>
            </button>

            <button class="btn-premium filter-btn"
                    type="button"
                    onclick="filterPrice(500)">
                <span>Under 500</span>
            </button>

            <button class="btn-premium filter-btn"
                    type="button"
                    onclick="filterPrice(1000)">
                <span>Under 1000</span>
            </button>

            <button class="btn-premium filter-btn"
                    type="button"
                    onclick="filterPrice(2000)">
                <span>Under 2000</span>
            </button>

        </div>

    </div>

</div>

	<!-- 8. EXPLORE CATALOG -->
<section id="explore-catalog" class="section-explore section-padding">
		<div class="container">
			<h2 class="centered-header">
				<i class="fa-solid fa-bag-shopping title-orange"></i> <span
					class="title-dark">EXPLORE</span> <span class="title-orange">CATALOG</span>
				<i class="fa-solid fa-bag-shopping title-orange"></i>
			</h2>
			<div class="product-grid" id="catalog-products">
				<% int count = 0; for(int i=14; i < products.size() && count < 50; i++) { Product p = products.get(i); %>
				<div class="product-card">
					<div class="card-header bg-pale">
					<button class="wishlist-btn-card"
        onclick="toggleWishlist(this, <%= p.getProductId() %>)">

    <i class="far fa-heart"></i>

</button>
						<img src="<%= p.getImage() %>" class="product-img" alt="<%= p.getName() %>">
					</div>
					<div class="card-body">
						<h3><%= p.getName() %></h3>
						<div class="stars">
    <% 
        double r = p.getRating(); 
        int fullStars = (int) r;
        boolean hasHalf = (r - fullStars) >= 0.5;
    %>

    <% for(int s = 1; s <= 5; s++) { %>

        <% if(s <= fullStars) { %>
            <i class="fa fa-star"></i>

        <% } else if(s == fullStars + 1 && hasHalf) { %>
            <i class="fa fa-star-half-alt"></i>

        <% } else { %>
            <i class="far fa-star"></i>

        <% } %>

    <% } %>

    <span class="rating-num">
        (<%= String.format("%.1f", r) %>)
    </span>
</div>
						<div class="price-action">
							<span class="price-text">₹<%= p.getPrice() %></span> <a
								href="ProductController?id=<%= p.getProductId() %>"
								class="btn-premium"><span>View Details</span></a>
						</div>
					</div>
				</div>
				<% count++; } %>
			</div>
		</div>
	</section>

	<!-- 9. TRANSFORM CTA -->
	<section class="cta-section">
		<div class="container">
			<h2>Ready to Transform Your Style?</h2>
			<p>Join over 50,000 fashion enthusiasts who choose premium
				quality every day.</p>
			<button class="btn-white-pill">
				Shop Now <i class="fa fa-bolt"></i>
			</button>
		</div>
	</section>

	<!-- 10. DETAILED PROFESSIONAL FOOTER -->
	<!-- =========================================================
         STANDARD FOOTER (Use this block in ALL JSPs)
         ========================================================= -->
    <!-- 10. DETAILED PROFESSIONAL FOOTER -->
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

    <a href="#explore-catalog">
        Men's Clothing
    </a>

    <a href="#explore-catalog">
        Women's Styles
    </a>

    <a href="#explore-catalog">
        Kids Collection
    </a>

    <a href="#explore-catalog">
        Premium Accessories
    </a>

    <a href="#explore-catalog">
        Footwear Hub
    </a>

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
let slides = document.querySelectorAll(".slide");
let index = 0;

function changeSlide() {
    slides[index].classList.remove("active");
    index = (index + 1) % slides.length;
    slides[index].classList.add("active");

    showHeroText(); // already added
}

setInterval(changeSlide, 4000);
</script>


<script>
window.addEventListener("load", () => {

    document.body.classList.add("loaded");

    setTimeout(() => {
        document.querySelectorAll(".overlay").forEach(el => el.classList.add("show"));
    }, 1000);

    setTimeout(() => {
        document.querySelector(".main-header").classList.add("show");
    }, 1500);

    setTimeout(() => {
        document.querySelector(".nav-links").classList.add("show");
    }, 2000);

 
    window.dispatchEvent(new Event("scroll"));
});
</script>


<script>
function showHeroText() {
    const activeSlide = document.querySelector(".slide.active");
    const overlay = activeSlide.querySelector(".overlay");

    overlay.classList.remove("show");

    setTimeout(() => {
        overlay.classList.add("show");
    }, 100);
}
</script>


<!-- 🔥 PASTE HERE -->
<script>
window.addEventListener("scroll", () => {

    document.querySelectorAll(".section-padding").forEach(section => {

        const rect = section.getBoundingClientRect();
        const trigger = window.innerHeight * 0.75; // 🔥 delay (comes late)

        if (rect.top < trigger && rect.bottom > 100) {
            section.classList.add("show");   // show when in view
        } else {
            section.classList.remove("show"); // 🔥 remove when out → repeat effect
        }

    });

});
</script>




<script>
window.addEventListener("load", function () {

    const params = new URLSearchParams(window.location.search);

    if (params.get("keyword")) {

        const section =
            document.getElementById("explore-catalog");

        if (section) {

            section.scrollIntoView({
                behavior: "smooth"
            });
        }
    }
});
</script>


<script>

window.onload = function () {

    const params = new URLSearchParams(window.location.search);

    if (
        params.get("keyword") ||
        params.get("category") ||
        params.get("price")
    ) {

        const section =
            document.getElementById("explore-catalog");

        if (section) {

            section.scrollIntoView({
                behavior: "smooth"
            });
        }
    }
};

</script>

<script>

let selectedCategory = "";
let selectedPrice = "";

// APPLY FILTERS
function applyFilters() {

    let url = "home?";

    if (selectedCategory !== "") {

        url += "category=" + encodeURIComponent(selectedCategory);
    }

    if (selectedPrice !== "") {

        if (selectedCategory !== "") {
            url += "&";
        }

        url += "price=" + encodeURIComponent(selectedPrice);
    }

    fetch(url)

    .then(response => response.text())

    .then(data => {

        const parser = new DOMParser();

        const doc =
            parser.parseFromString(data, "text/html");

        const newProducts =
            doc.querySelector("#catalog-products");

        document.querySelector("#catalog-products")
            .innerHTML = newProducts.innerHTML;

        // SCROLL TO CATALOG
        const catalog =
            document.getElementById("explore-catalog");

        window.scrollTo({
            top: catalog.offsetTop - 120,
            behavior: "smooth"
        });
    });
}

// CATEGORY FILTER
function filterProducts(category) {

    selectedCategory = category;

    // CHANGE BUTTON TEXT
    document.getElementById("categoryText")
        .innerText = category;

    applyFilters();

    // CLOSE DROPDOWN
    document.querySelector(".dropdown")
        .classList.remove("active");
}

function filterPrice(price) {

    selectedPrice = price;

    // REMOVE ACTIVE FROM ALL
    document.querySelectorAll(".filter-btn")
    .forEach(btn => {
        btn.classList.remove("active");
    });

    // ADD ACTIVE TO CLICKED
    event.currentTarget.classList.add("active");

    applyFilters();
}

// TOGGLE DROPDOWN
document.querySelector(".btn-category-main")
.addEventListener("click", function(e){

    e.stopPropagation();

    document.querySelector(".dropdown")
        .classList.toggle("active");
});

// CLOSE DROPDOWN OUTSIDE
document.addEventListener("click", function(){

    document.querySelector(".dropdown")
        .classList.remove("active");
});

</script>

<script>

window.addEventListener("load", function () {

    const params =
        new URLSearchParams(window.location.search);

    if(params.get("keyword")){

        const section =
            document.getElementById("explore-catalog");

        if(section){

            section.scrollIntoView({
                behavior: "smooth"
            });
        }
    }
});

</script>



<script>

function toggleWishlist(btn, productId){

    const icon = btn.querySelector("i");

    const card = btn.closest(".product-card");

    // ADD TO WISHLIST
    if(!btn.classList.contains("active")){

        btn.classList.add("active");

        icon.classList.remove("far");
        icon.classList.add("fas");

        icon.style.color = "red";

        fetch("WishlistController?action=add&productId=" + productId);

        // KEEP CARD VISIBLE
        if(card){
            card.style.display = "block";
        }

        // REMOVE ANIMATION AFTER 2 SEC
        setTimeout(() => {

            btn.classList.remove("active");

            icon.classList.remove("fas");
            icon.classList.add("far");

            icon.style.color = "";

        }, 2000);

    }else{

        // REMOVE FROM WISHLIST
        btn.classList.remove("active");

        icon.classList.remove("fas");
        icon.classList.add("far");

        icon.style.color = "";

        fetch("RemoveWishlistController?productId=" + productId);

        // KEEP CARD VISIBLE
        if(card){
            card.style.display = "block";
        }
    }
}

</script>







</body>
</html>