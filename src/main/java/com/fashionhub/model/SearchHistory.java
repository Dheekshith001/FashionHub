package com.fashionhub.model;

public class SearchHistory {

    private int searchId;
    private int userId;
    private String keyword;
    private String searchedAt;

    public SearchHistory() {
    }

    public int getSearchId() {
        return searchId;
    }

    public void setSearchId(int searchId) {
        this.searchId = searchId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSearchedAt() {
        return searchedAt;
    }

    public void setSearchedAt(String searchedAt) {
        this.searchedAt = searchedAt;
    }
}