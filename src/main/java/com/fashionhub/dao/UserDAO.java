package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.fashionhub.model.User;
import com.fashionhub.util.DBConnection;

public class UserDAO {

    private static final DateTimeFormatter JOIN_DATE_FMT = DateTimeFormatter.ofPattern("MMM d, yyyy");

    private static boolean hasColumn(ResultSet rs, String label) throws SQLException {
        ResultSetMetaData md = rs.getMetaData();
        for (int i = 1; i <= md.getColumnCount(); i++) {
            if (label.equalsIgnoreCase(md.getColumnLabel(i))) {
                return true;
            }
        }
        return false;
    }

    /**
     * Maps a users row. Password is only set when {@code includePassword} is true (avoid leaking hashes to session).
     */
    private User mapUser(ResultSet rs, boolean includePassword) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        if (includePassword) {
            user.setPassword(rs.getString("password"));
        }
        user.setPhone(rs.getString("phone"));
        user.setGender(rs.getString("gender"));
        user.setDob(rs.getString("dob"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setAddress(rs.getString("address"));
        user.setCity(rs.getString("city"));
        user.setState(rs.getString("state"));
        user.setPincode(rs.getString("pincode"));

        if (hasColumn(rs, "created_at")) {
            Timestamp ts = rs.getTimestamp("created_at");
            if (ts != null) {
                LocalDate d = ts.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                user.setJoinDate(JOIN_DATE_FMT.format(d));
            }
        }
        return user;
    }

    public boolean registerUser(User user) {

        boolean status = false;

        try {
            Connection connection = DBConnection.getConnection();

            String query = "INSERT INTO users(name, email, password, phone, gender, dob, profile_image, address, city, state, pincode) VALUES(?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getGender());
            preparedStatement.setString(6, user.getDob());
            preparedStatement.setString(7, user.getProfileImage());
            preparedStatement.setString(8, user.getAddress());
            preparedStatement.setString(9, user.getCity());
            preparedStatement.setString(10, user.getState());
            preparedStatement.setString(11, user.getPincode());

            int rows = preparedStatement.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public User loginUser(String email, String password) {

        User user = null;

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = mapUser(resultSet, false);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public User getUserById(int userId) {
        try {
            Connection connection = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE user_id=? LIMIT 1";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs, false);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProfile(int userId, String name, String phone, String address, String city, String state,
            String pincode, String profileImageFileName) {

        if (userId <= 0) {
            return false;
        }

        try {
            Connection connection = DBConnection.getConnection();

            String query = "UPDATE users SET name=?, phone=?, address=?, city=?, state=?, pincode=?, profile_image=? WHERE user_id=?";

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, state);
            ps.setString(6, pincode);
            ps.setString(7, profileImageFileName);
            ps.setInt(8, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean emailExists(String email) {

        if (email == null || email.isBlank()) {
            return false;
        }

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT 1 FROM users WHERE email=? LIMIT 1";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email.trim());

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {

        if (email == null || email.isBlank() || newPassword == null || newPassword.isBlank()) {
            return false;
        }

        try {
            Connection connection = DBConnection.getConnection();

            String query = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, email.trim());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
