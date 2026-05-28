package com.fashionhub.util;

import java.io.IOException;

import com.fashionhub.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Session keys and safe redirects for FashionHub authentication.
 */
public final class AuthUtil {

    public static final String SESSION_USER = "user";
    /** Shown once on auth.jsp after redirect from protected resource */
    public static final String SESSION_AUTH_NOTICE = "authNotice";
    /** Full app URL (including context path) to open after successful login */
    public static final String SESSION_POST_LOGIN_REDIRECT = "postLoginRedirect";
    /** One-shot success banner on auth.jsp (e.g. password reset) */
    public static final String SESSION_AUTH_SUCCESS = "authSuccess";
    /** One-shot banner after placing an order */
    public static final String SESSION_ORDERS_FLASH = "ordersFlash";

    private AuthUtil() {
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(SESSION_USER) instanceof User;
    }

    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object u = session.getAttribute(SESSION_USER);
        return u instanceof User ? (User) u : null;
    }

    /**
     * Redirects to auth.jsp and stores optional return URL for post-login navigation.
     *
     * @param returnUrl full URL including context path (e.g. from request.getRequestURI() + query)
     */
    public static void redirectToAuthLogin(HttpServletRequest request, HttpServletResponse response,
            String returnUrl) throws IOException {
        HttpSession session = request.getSession(true);
        session.setAttribute(SESSION_AUTH_NOTICE, "Please login to continue");
        if (returnUrl != null && isSafeInternalRedirect(returnUrl, request)) {
            session.setAttribute(SESSION_POST_LOGIN_REDIRECT, returnUrl);
        }
        response.sendRedirect(request.getContextPath() + "/customer/auth.jsp");
    }

    /**
     * Allows only same-origin paths under the application context.
     */
    public static boolean isSafeInternalRedirect(String url, HttpServletRequest request) {
        if (url == null || url.isBlank()) {
            return false;
        }
        String trimmed = url.trim();
        if (trimmed.contains("://") || trimmed.toLowerCase().startsWith("//")) {
            return false;
        }
        if (trimmed.contains("..")) {
            return false;
        }
        String cp = request.getContextPath();
        if (cp == null) {
            cp = "";
        }
        return trimmed.startsWith(cp + "/");
    }

    public static String defaultPostLoginTarget(HttpServletRequest request) {
        return request.getContextPath() + "/ProductController";
    }

    /**
     * Resolves redirect after login: returnUrl param &gt; session &gt; default catalog.
     */
    public static String resolvePostLoginRedirect(HttpServletRequest request, HttpSession session,
            String returnUrlParam) {
        if (returnUrlParam != null && isSafeInternalRedirect(returnUrlParam.trim(), request)) {
            session.removeAttribute(SESSION_POST_LOGIN_REDIRECT);
            return returnUrlParam.trim();
        }
        Object stored = session.getAttribute(SESSION_POST_LOGIN_REDIRECT);
        session.removeAttribute(SESSION_POST_LOGIN_REDIRECT);
        if (stored instanceof String && isSafeInternalRedirect((String) stored, request)) {
            return (String) stored;
        }
        return defaultPostLoginTarget(request);
    }

    public static String htmlEscapeAttr(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;");
    }
}
