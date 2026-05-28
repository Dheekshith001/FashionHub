package com.fashionhub.controller;

import java.io.IOException;
import java.io.File;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/ProfileController")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 8 * 1024 * 1024, fileSizeThreshold = 0)
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User sessionUser = AuthUtil.getCurrentUser(request);
        if (sessionUser == null) {
            AuthUtil.redirectToAuthLogin(request, response,
                    request.getContextPath() + "/ProfileController");
            return;
        }

        UserDAO dao = new UserDAO();
        User fresh = dao.getUserById(sessionUser.getUserId());
        if (fresh == null) {
            AuthUtil.redirectToAuthLogin(request, response, request.getContextPath() + "/ProfileController");
            return;
        }

        request.setAttribute("profile", fresh);
        if ("1".equals(request.getParameter("saved"))) {
            request.setAttribute("profileSaved", Boolean.TRUE);
        }
        if ("1".equals(request.getParameter("edit"))) {
            request.setAttribute("profileEditMode", Boolean.TRUE);
        }
        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User sessionUser = AuthUtil.getCurrentUser(request);
        if (sessionUser == null) {
            AuthUtil.redirectToAuthLogin(request, response,
                    request.getContextPath() + "/ProfileController");
            return;
        }

        String name = trimToNull(request.getParameter("name"));
        String phone = trimToNull(request.getParameter("phone"));
        String address = trimToNull(request.getParameter("address"));
        String city = trimToNull(request.getParameter("city"));
        String state = trimToNull(request.getParameter("state"));
        String pincode = trimToNull(request.getParameter("pincode"));

        UserDAO dao = new UserDAO();
        User existing = dao.getUserById(sessionUser.getUserId());
        if (existing == null) {
            AuthUtil.redirectToAuthLogin(request, response, request.getContextPath() + "/ProfileController");
            return;
        }

        String profileFile = existing.getProfileImage() != null ? existing.getProfileImage() : "default.png";

        try {
            Part part = request.getPart("profileImage");
            if (part != null && part.getSize() > 0) {
                String submitted = part.getSubmittedFileName();
                String ext = safeImageExtension(submitted);
                if (ext != null) {
                    String newName = UUID.randomUUID().toString().replace("-", "") + ext;
                    Path dir = resolveUploadDir(request);
                    Files.createDirectories(dir);
                    Path target = dir.resolve(newName);
                    try (InputStream in = part.getInputStream()) {
                        Files.copy(in, target, StandardCopyOption.REPLACE_EXISTING);
                    }
                    profileFile = newName;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        if (name == null || name.isBlank()) {
            name = existing.getName();
        }

        boolean ok = dao.updateProfile(sessionUser.getUserId(), name, phoneOrEmpty(phone), addressOrEmpty(address),
                cityOrEmpty(city), stateOrEmpty(state), pincodeOrEmpty(pincode), profileFile);

        if (!ok) {
            User still = dao.getUserById(sessionUser.getUserId());
            request.setAttribute("profile", still != null ? still : existing);
            request.setAttribute("profileError", "We could not save your changes. Please try again.");
            request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
            return;
        }

        User refreshed = dao.getUserById(sessionUser.getUserId());
        if (refreshed != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute(AuthUtil.SESSION_USER, refreshed);
        }

        response.sendRedirect(request.getContextPath() + "/ProfileController?saved=1");
    }

    private static String trimToNull(String s) {
        if (s == null) {
            return null;
        }
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static String phoneOrEmpty(String phone) {
        return phone == null ? "" : phone;
    }

    private static String addressOrEmpty(String address) {
        return address == null ? "" : address;
    }

    private static String cityOrEmpty(String city) {
        return city == null ? "" : city;
    }

    private static String stateOrEmpty(String state) {
        return state == null ? "" : state;
    }

    private static String pincodeOrEmpty(String pincode) {
        return pincode == null ? "" : pincode;
    }

    private static String safeImageExtension(String submitted) {
        if (submitted == null) {
            return null;
        }
        int dot = submitted.lastIndexOf('.');
        if (dot < 0 || dot == submitted.length() - 1) {
            return null;
        }
        String ext = submitted.substring(dot).toLowerCase();
        if (".jpg".equals(ext) || ".jpeg".equals(ext) || ".png".equals(ext) || ".gif".equals(ext) || ".webp".equals(ext)) {
            return ext;
        }
        return null;
    }

    private static Path resolveUploadDir(HttpServletRequest request) {
        String base = request.getServletContext().getRealPath("/");
        if (base == null) {
            return Paths.get("uploads", "profiles");
        }
        return Paths.get(base, "uploads", "profiles");
    }
}
