<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.fashionhub.model.User"%>
<%@ page import="com.fashionhub.util.ProfileImageUtil"%>
<%
    User p = (User) request.getAttribute("profile");
    if (p == null) {
        response.sendRedirect(request.getContextPath() + "/ProfileController");
        return;
    }
    String profileError = (String) request.getAttribute("profileError");
    Boolean profileSaved = (Boolean) request.getAttribute("profileSaved");
    Boolean profileEditMode = (Boolean) request.getAttribute("profileEditMode");
    boolean editing = profileEditMode != null && profileEditMode.booleanValue();
    String ctx = request.getContextPath();
    String avatarUrl = ProfileImageUtil.urlForProfileImage(request, p);

    String safe = p.getName() != null ? p.getName() : "";
    String safePhone = p.getPhone() != null ? p.getPhone() : "";
    String safeAddr = p.getAddress() != null ? p.getAddress() : "";
    String safeCity = p.getCity() != null ? p.getCity() : "";
    String safeState = p.getState() != null ? p.getState() : "";
    String safePin = p.getPincode() != null ? p.getPincode() : "";
    String join = p.getJoinDate() != null && !p.getJoinDate().isBlank() ? p.getJoinDate() : "—";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | FashionHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;0,900;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
    <link rel="stylesheet" href="<%= ctx %>/css/nav-account.css">
    <link rel="stylesheet" href="<%= ctx %>/css/profile.css">
</head>
<body class="home-page loaded profile-page">

<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<main class="profile-shell">
    <div class="container">

        <% if (Boolean.TRUE.equals(profileSaved)) { %>
        <div class="pf-flash pf-flash--ok" role="status"><i class="fas fa-circle-check"></i> Profile updated successfully.</div>
        <% } %>
        <% if (profileError != null) { %>
        <div class="pf-flash pf-flash--err" role="alert"><i class="fas fa-circle-exclamation"></i> <%= profileError %></div>
        <% } %>

        <div class="profile-grid">
            <aside class="profile-card" data-profile-card>
                <div class="profile-hero">
                    <img class="profile-avatar" src="<%= avatarUrl %>" alt="Profile photo">
                    <div class="profile-name"><%= p.getName() != null ? p.getName() : "Member" %></div>
                    <div class="profile-email"><%= p.getEmail() != null ? p.getEmail() : "" %></div>
                    <div class="profile-meta">Member since <%= join %></div>
                </div>
                <div class="profile-actions">
                    <button type="button" class="pf-btn pf-btn--primary" data-profile-edit><i class="fas fa-pen"></i> Edit Profile</button>
                </div>
            </aside>

            <section class="profile-panel">
                <div class="profile-panel__head">
                    <h1 class="profile-panel__title">Account details</h1>
                </div>

                <div class="profile-panel__body">
                    <div class="pf-kv" data-profile-view style="<%= editing ? "display:none;" : "" %>">
                        <div class="pf-k">User ID</div>
                        <div class="pf-v">#<%= p.getUserId() %></div>

                        <div class="pf-k">Full name</div>
                        <div class="pf-v"><%= p.getName() != null ? p.getName() : "—" %></div>

                        <div class="pf-k">Email</div>
                        <div class="pf-v"><%= p.getEmail() != null ? p.getEmail() : "—" %></div>

                        <div class="pf-k">Phone</div>
                        <div class="pf-v"><%= p.getPhone() != null && !p.getPhone().isBlank() ? p.getPhone() : "—" %></div>

                        <div class="pf-k">Address</div>
                        <div class="pf-v"><%= p.getAddress() != null && !p.getAddress().isBlank() ? p.getAddress() : "—" %></div>

                        <div class="pf-k">City</div>
                        <div class="pf-v"><%= p.getCity() != null && !p.getCity().isBlank() ? p.getCity() : "—" %></div>

                        <div class="pf-k">State</div>
                        <div class="pf-v"><%= p.getState() != null && !p.getState().isBlank() ? p.getState() : "—" %></div>

                        <div class="pf-k">Pincode</div>
                        <div class="pf-v"><%= p.getPincode() != null && !p.getPincode().isBlank() ? p.getPincode() : "—" %></div>

                        <div class="pf-k">Join date</div>
                        <div class="pf-v"><%= join %></div>
                    </div>

                    <form class="pf-form" data-profile-form method="post" action="<%= ctx %>/ProfileController"
                          enctype="multipart/form-data" style="<%= editing ? "" : "display:none;" %>">
                        <div class="pf-muted">User ID: <strong>#<%= p.getUserId() %></strong> &nbsp;·&nbsp; Email is read-only:
                            <strong><%= p.getEmail() != null ? p.getEmail() : "" %></strong>
                        </div>

                        <div class="pf-field">
                            <input id="pf-name" name="name" type="text" value="<%= safe %>" placeholder=" " autocomplete="name" required>
                            <label for="pf-name">Full name</label>
                        </div>

                        <div class="pf-field">
                            <input id="pf-phone" name="phone" type="tel" value="<%= safePhone %>" placeholder=" " autocomplete="tel">
                            <label for="pf-phone">Phone</label>
                        </div>

                        <div class="pf-field">
                            <textarea id="pf-address" name="address" placeholder=" " autocomplete="street-address"><%= safeAddr %></textarea>
                            <label for="pf-address">Address</label>
                        </div>

                        <div class="pf-field">
                            <input id="pf-city" name="city" type="text" value="<%= safeCity %>" placeholder=" " autocomplete="address-level2">
                            <label for="pf-city">City</label>
                        </div>

                        <div class="pf-field">
                            <input id="pf-state" name="state" type="text" value="<%= safeState %>" placeholder=" " autocomplete="address-level1">
                            <label for="pf-state">State</label>
                        </div>

                        <div class="pf-field">
                            <input id="pf-pin" name="pincode" type="text" value="<%= safePin %>" placeholder=" " inputmode="numeric" autocomplete="postal-code">
                            <label for="pf-pin">Pincode</label>
                        </div>

                        <div class="pf-upload">
                            <div class="pf-muted">Profile image (JPG, PNG, WEBP, GIF — max 5MB)</div>
                            <input type="file" name="profileImage" accept="image/*">
                        </div>

                        <div style="display:flex; gap:10px; flex-wrap:wrap;">
                            <button type="submit" class="pf-btn pf-btn--primary" style="width:auto; min-width: 220px;">
                                <i class="fas fa-floppy-disk"></i> Save changes
                            </button>
                            <button type="button" class="pf-btn pf-btn--ghost" style="width:auto; min-width: 160px;" data-profile-cancel-form>
                                <i class="fas fa-xmark"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </section>
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
<script>
(function () {
    var editing = <%= editing ? "true" : "false" %>;
    var view = document.querySelector('[data-profile-view]');
    var form = document.querySelector('[data-profile-form]');
    var editBtn = document.querySelector('[data-profile-edit]');
    var cancelBtn = document.querySelector('[data-profile-cancel-form]');

    function setMode(isEdit) {
        if (!view || !form) return;
        if (isEdit) {
            view.style.display = 'none';
            form.style.display = 'grid';
            if (editBtn) editBtn.setAttribute('hidden', 'hidden');
        } else {
            view.style.display = 'grid';
            form.style.display = 'none';
            if (editBtn) editBtn.removeAttribute('hidden');
        }
    }

    if (editBtn) {
        editBtn.addEventListener('click', function () { setMode(true); });
    }
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function () { setMode(false); });
    }

    if (editing) {
        setMode(true);
    }
})();
</script>

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
