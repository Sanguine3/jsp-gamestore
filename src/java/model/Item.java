/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Objects;

public class Item {
    private Product product;
    private int quantity;
    private double price;
    private double subtotal;

    public Item() {
    }

    public Item(Product product, int quantity, double price) {
        this.product = product;
        this.quantity = quantity;
        this.price = price;
        this.calculateSubtotal();
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.calculateSubtotal();
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
        this.calculateSubtotal();
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    // Helper method to calculate subtotal
    private void calculateSubtotal() {
        this.subtotal = this.quantity * this.price;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        var item = (Item) obj;
        return quantity == item.quantity && 
               Double.compare(item.price, price) == 0 &&
               Objects.equals(product, item.product);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(product, quantity, price);
    }
    
    @Override
    public String toString() {
        return "Item{" +
               "product=" + (product != null ? product.getName() : "null") +
               ", quantity=" + quantity +
               ", price=" + price +
               ", subtotal=" + subtotal +
               '}';
    }
}
