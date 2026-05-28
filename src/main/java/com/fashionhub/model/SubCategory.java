package com.fashionhub.model;

/**
 * Maps table {@code subcategories} (subcategory_id, category_id, subcategory_name).
 * Place file: {@code src/main/java/com/fashionhub/model/SubCategory.java}
 */
public class SubCategory {

    private int subcategoryId;
    private int categoryId;
    private String subcategoryName;

    public SubCategory() {
    }

    public int getSubcategoryId() {
        return subcategoryId;
    }

    public void setSubcategoryId(int subcategoryId) {
        this.subcategoryId = subcategoryId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getSubcategoryName() {
        return subcategoryName;
    }

    public void setSubcategoryName(String subcategoryName) {
        this.subcategoryName = subcategoryName;
    }
}
