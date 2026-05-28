<%@ page isELIgnored="false"%>
<%@ page import="com.fashionhub.model.Product" %>
<%@ page import="java.util.List" %>
<%
Product p = (Product) request.getAttribute("product");
List<Product> similar = (List<Product>) request.getAttribute("similarProducts");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= p.getName() %></title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/nav-account.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/product.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

<body class="home-page loaded fh-shop-page">

<div id="content-area">

<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<!-- PRODUCT -->
<div class="main-container show">

    <div class="left-col">
        <div class="img-wrapper">
            <img src="<%= p.getImage() %>" class="main-product-img" id="zoomImg">
        </div>
    </div>

    <div class="right-col">

        <h2 class="brand"><%= (p.getBrand()!=null)?p.getBrand():"FashionHub" %></h2>
        <p class="p-name"><%= p.getName() %></p>

        <!-- RATING -->
        <div class="stars">
        <%
        double r = p.getRating();
        int full = (int) r;
        boolean half = (r - full) >= 0.5;
        %>

        <% for(int i=1;i<=5;i++){ %>
            <% if(i <= full){ %>
                <i class="fa fa-star"></i>
            <% } else if(i == full+1 && half){ %>
                <i class="fa fa-star-half-alt"></i>
            <% } else { %>
                <i class="far fa-star"></i>
            <% } %>
        <% } %>

        <span class="rating-num">(<%= String.format("%.1f", r) %>)</span>
        </div>

<span class="price-text"> &#8377;<%= String.format("%.2f", p.getPrice()) %></span>


      <%
int categoryId = p.getCategoryId();

boolean isFootwear = categoryId == 4;
boolean hideSize =
        categoryId == 5 || categoryId == 6;
%>

<% if(!hideSize) { %>

<p class="size-label">SELECT SIZE</p>

<div class="size-btns">

    <% if(isFootwear) { %>

        <button class="s-btn">6</button>
        <button class="s-btn">7</button>
        <button class="s-btn">8</button>
        <button class="s-btn">9</button>
        <button class="s-btn">10</button>

    <% } else { %>

        <button class="s-btn">S</button>
        <button class="s-btn">M</button>
        <button class="s-btn">L</button>
        <button class="s-btn">XL</button>
        <button class="s-btn">XXL</button>

    <% } %>

</div>

<% } %>

<% if(!hideSize) { %>
<p id="error" style="color:red; display:none;">Select size</p>
<% } %>

        <button class="add-bag" onclick="addToCart('<%= p.getProductId() %>')">
            ADD TO BAG
        </button>

        <p style="margin-top:14px;">
            <a class="btn-premium" href="<%= request.getContextPath() %>/WishlistController?action=add&productId=<%= p.getProductId() %>">
                <span>Add to wishlist</span>
            </a>
        </p>

    </div>
</div>

<!-- SIMILAR -->
<div class="section-top-selling">
    <div class="container">

        <h2 class="centered-header">
            <span class="title-dark">SIMILAR</span>
            <span class="title-orange">PRODUCTS</span>
        </h2>

        <div class="product-grid">

        <% if(similar != null && !similar.isEmpty()){ %>

            <% for(Product sp : similar){ %>

            <div class="product-card">

                <div class="card-header">
                    <button class="wishlist-btn-card">
                        <i class="far fa-heart"></i>
                    </button>

                    <img src="<%= sp.getImage() %>" class="product-img">
                </div>

                <div class="card-body">

                    <h3><%= sp.getName() %></h3>
                    <!-- ⭐ RATING -->
<div class="stars">
<%
    double sr = sp.getRating(); 
    int sfull = (int) sr;
    boolean shalf = (sr - sfull) >= 0.5;
%>

<% for(int i=1;i<=5;i++){ %>
    <% if(i <= sfull){ %>
        <i class="fa fa-star"></i>
    <% } else if(i == sfull+1 && shalf){ %>
        <i class="fa fa-star-half-alt"></i>
    <% } else { %>
        <i class="far fa-star"></i>
    <% } %>
<% } %>

<span class="rating-num">
    (<%= String.format("%.1f", sr) %>)
</span>
</div>

                    <div class="price-action">
<span class="price-text"> &#8377;<%= String.format("%.2f", sp.getPrice()) %></span>
                        <button class="btn-premium" onclick="loadProduct(<%= sp.getProductId() %>)">
                            <span>View Details</span>
                        </button>
                    </div>

                </div>

            </div>

            <% } %>

        <% } %>

        </div>

    </div>
</div>

</div>

<!-- ================= SCRIPT ================= -->
<script>

let selectedSize = null;

// ADD TO CART
function addToCart(id){

    const hideSize =
        <%= (p.getCategoryId() == 5 || p.getCategoryId() == 6) %>;

    // REQUIRE SIZE ONLY FOR CLOTHES/FOOTWEAR
    if(!hideSize && !selectedSize){
        document.getElementById('error').style.display="block";
        return;
    }

    <% if (session.getAttribute("user") == null) { %>

    var ctx = "<%= request.getContextPath() %>";

    let target;

    if(hideSize){

        target =
            ctx + "/CartController?id=" + encodeURIComponent(id);

    } else {

        target =
            ctx + "/CartController?id="
            + encodeURIComponent(id)
            + "&size="
            + encodeURIComponent(selectedSize);
    }

    window.location.href =
        ctx + "/customer/auth.jsp?return="
        + encodeURIComponent(target);

    return;

    <% } %>

    // LOGGED IN USER
    if(hideSize){

        window.location.href =
            "<%= request.getContextPath() %>/CartController?id=" + id;

    } else {

        window.location.href =
            "<%= request.getContextPath() %>/CartController?id="
            + id
            + "&size="
            + encodeURIComponent(selectedSize);
    }
}

// LOAD PRODUCT
function loadProduct(id) {

    fetch("ProductController?id=" + id)
    .then(res => res.text())
    .then(html => {

        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");

        const newContent =
            doc.querySelector("#content-area");

        document.getElementById("content-area").innerHTML =
            newContent.innerHTML;

        window.scrollTo(0, 0);

        attachEvents();
    });
}

// ATTACH EVENTS
function attachEvents() {

    document.querySelectorAll('.s-btn').forEach(btn=>{

        btn.onclick = ()=>{

            document.querySelectorAll('.s-btn')
            .forEach(b=>b.classList.remove('active'));

            btn.classList.add('active');

            selectedSize = btn.innerText;

            const err =
                document.getElementById('error');

            if(err){
                err.style.display = "none";
            }
        }
    });

    const img = document.getElementById("zoomImg");

    if(img){

        img.onmousemove = function(e){

            const rect =
                img.getBoundingClientRect();

            const x =
                ((e.clientX - rect.left)
                / rect.width) * 100;

            const y =
                ((e.clientY - rect.top)
                / rect.height) * 100;

            img.style.transformOrigin =
                x + "% " + y + "%";

            img.style.transform = "scale(2)";
        };

        img.onmouseleave = function(){

            img.style.transform = "scale(1)";
        };
    }
}

// PAGE LOAD
window.onload = function(){

    document.body.classList.add("loaded");

    attachEvents();
};

</script>
</body>
</html>