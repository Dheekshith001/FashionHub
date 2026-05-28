package com.fashionhub.model;

public class ForgotPassword {

    private int forgotId;
    private int userId;
    private String otp;
    private String createdAt;

    public ForgotPassword() {
    }

    public int getForgotId() {
        return forgotId;
    }

    public void setForgotId(int forgotId) {
        this.forgotId = forgotId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}