<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.fashionhub.model.Product"%>
<%@ page import="com.fashionhub.model.Category"%>
<%@ page import="com.fashionhub.model.SubCategory"%>

<%

    @SuppressWarnings("unchecked")
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
    if (products == null) {
        products = new ArrayList<>();
    }
    Category selectedCategory = (Category) request.getAttribute("selectedCategory");
    String selectedSubCategory = (String) request.getAttribute("selectedSubCategory");
    @SuppressWarnings("unchecked")
    ArrayList<SubCategory> subcategories = (ArrayList<SubCategory>) request.getAttribute("subcategories");
    if (subcategories == null) {
        subcategories = new ArrayList<>();
    }
    @SuppressWarnings("unchecked")
    ArrayList<String> brands = (ArrayList<String>) request.getAttribute("brands");
    if (brands == null) {
        brands = new ArrayList<>();
    }
    String filterBrand = request.getAttribute("filterBrand") != null
            ? String.valueOf(request.getAttribute("filterBrand"))
            : "";
    Double filterMinPrice = (Double) request.getAttribute("filterMinPrice");
    Double filterMaxPrice = (Double) request.getAttribute("filterMaxPrice");
    Double filterRating = (Double) request.getAttribute("filterRating");

    int categoryId = 0;
    if (selectedCategory != null) {
        categoryId = selectedCategory.getCategoryId();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FashionHub | Shop</title>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/nav-account.css">
</head>
<body class="home-page loaded catalog-page fh-shop-page">

<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<div class="catalog-wrap">
    <div class="catalog-layout">

        <aside class="catalog-filters" aria-label="Filters">
            <h2>FILTERS</h2>
            
            

<form class="filter-form" method="get"
    action="${pageContext.request.contextPath}/CategoryController">

    <input type="hidden" name="category"
        value="<%= categoryId > 0 ? categoryId : "" %>">

    <!-- BRAND -->
    <div class="filter-field">
        <label for="f-brand">Brand</label>

        <input type="text"
            id="f-brand"
            name="brand"
            value="<%= filterBrand %>"
            placeholder="e.g. Nike"
            list="brand-list">

        <datalist id="brand-list">
            <% for (String b : brands) { %>
            <option value="<%= b %>"></option>
            <% } %>
        </datalist>
    </div>

   
<!-- SIZE -->
<div class="filter-field">

    <label for="f-size">Size</label>

    <select id="f-size" name="size">

        <option value="">All</option>

        <% if(categoryId == 4){ %>

            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>

        <% } else if(categoryId != 5 && categoryId != 6){ %>

            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>

        <% } %>

    </select>

</div>

    <!-- MIN PRICE -->
    <div class="filter-field">
        <label for="f-min">Min price (₹)</label>

        <input type="number"
            step="0.01"
            min="0"
            id="f-min"
            name="minPrice"
            value="<%= filterMinPrice != null ? filterMinPrice : "" %>"
            placeholder="Any">
    </div>

    <!-- MAX PRICE -->
    <div class="filter-field">
        <label for="f-max">Max price (₹)</label>

        <input type="number"
            step="0.01"
            min="0"
            id="f-max"
            name="maxPrice"
            value="<%= filterMaxPrice != null ? filterMaxPrice : "" %>"
            placeholder="Any">
    </div>

    <!-- BUTTONS -->
    <div class="filter-actions">

        <button type="submit">
            Apply
        </button>

        <a href="${pageContext.request.contextPath}/CategoryController<%= categoryId > 0 ? "?category=" + categoryId : "" %>">
            Clear filters
        </a>

    </div>

</form>
            
        </aside>

        <section class="catalog-main">
            <h1>
                <%
                    if (selectedCategory != null) {
                %>
                <%= selectedCategory.getCategoryName() %>
                <%
                    } else {
                %>
                All products
                <%
                    }
                    if (selectedSubCategory != null && !selectedSubCategory.isEmpty()) {
                %>
                <span style="font-weight:600;color:#666;"> · <%= selectedSubCategory %></span>
                <%
                    }
                %>
            </h1>

            <% if (products.isEmpty()) { %>
            <p class="catalog-empty">No products match these filters.</p>
            <% } else { %>
            <div class="product-grid">
                <% for (Product p : products) { %>
                <div class="product-card">
                    <div class="card-header bg-pale">
                       <button class="wishlist-btn-card"
        type="button"
        aria-label="Wishlist"
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
                                for (int s = 1; s <= 5; s++) {
                                    if (s <= fullStars) {
                            %>
                            <i class="fa fa-star"></i>
                            <%
                                    } else if (s == fullStars + 1 && hasHalf) {
                            %>
                            <i class="fa fa-star-half-alt"></i>
                            <%
                                    } else {
                            %>
                            <i class="far fa-star"></i>
                            <%
                                    }
                                }
                            %>
                            <span class="rating-num">(<%= String.format("%.1f", r) %>)</span>
                        </div>
                        <div class="price-action">
                            <span class="price-text">₹<%= p.getPrice() %></span>
                            <a href="${pageContext.request.contextPath}/ProductController?id=<%= p.getProductId() %>"
                                class="btn-premium"><span>View Details</span></a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </section>
    </div>
</div>



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
            card.style.display = "";
        }
    }
}

</script>

</body>
</html>
