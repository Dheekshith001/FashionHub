package com.fashionhub.util;

import com.fashionhub.model.User;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Resolves profile image URL for JSPs and navbar.
 */
public final class ProfileImageUtil {

    private ProfileImageUtil() {
    }

    public static String urlForProfileImage(HttpServletRequest request, User user) {
        if (request == null) {
            return "";
        }
        String ctx = request.getContextPath();
        if (ctx == null) {
            ctx = "";
        }
        if (user == null) {
            return ctx + "/images/logo.png";
        }
        String img = user.getProfileImage();
        if (img == null || img.isBlank() || "default.png".equalsIgnoreCase(img.trim())) {
            return ctx + "/images/default.png";
        }
        String trimmed = img.trim();
        if (trimmed.startsWith("http://") || trimmed.startsWith("https://")) {
            return trimmed;
        }
        if (trimmed.startsWith("/")) {
            return ctx + trimmed;
        }
        return ctx + "/uploads/profiles/" + trimmed;
    }
}
