package com.fashionhub.model;

/**
 * Cart row plus resolved product for cart.jsp rendering.
 */
public class CartLineItem {

    private Cart cart;
    private Product product;

    public CartLineItem() {
    }

    public CartLineItem(Cart cart, Product product) {
        this.cart = cart;
        this.product = product;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
