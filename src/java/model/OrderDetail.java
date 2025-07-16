/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.time.LocalDateTime;
import java.util.Objects;

public class OrderDetail {
    private int id;
    private int orderId;  // was oid
    private int productId; // was pid
    private String productName;
    private int quantity;
    private double unitPrice; // was price
    private double subtotal;
    private LocalDateTime createdAt;
    
    // Reference to product (for backward compatibility)
    private Product product;

    public OrderDetail() {
    }

    // Constructor for backward compatibility
    public OrderDetail(int orderId, int productId, int quantity, double price) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.unitPrice = price;
        this.subtotal = quantity * price;
        this.createdAt = LocalDateTime.now();
    }
    
    // Full constructor
    public OrderDetail(int id, int orderId, int productId, String productName, 
                      int quantity, double unitPrice, double subtotal, LocalDateTime createdAt) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.subtotal = subtotal;
        this.createdAt = createdAt;
    }

    // Constructor with product reference
    public OrderDetail(int orderId, Product product, int quantity) {
        this.orderId = orderId;
        this.productId = product.getId();
        this.productName = product.getName();
        this.quantity = quantity;
        this.unitPrice = product.getPrice();
        this.subtotal = quantity * product.getPrice();
        this.product = product;
        this.createdAt = LocalDateTime.now();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    // For backward compatibility
    public int getOid() {
        return orderId;
    }

    // For backward compatibility
    public void setOid(int oid) {
        this.orderId = oid;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    // For backward compatibility
    public int getPid() {
        return productId;
    }

    // For backward compatibility
    public void setPid(int pid) {
        this.productId = pid;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        calculateSubtotal();
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
        calculateSubtotal();
    }
    
    // For backward compatibility
    public double getPrice() {
        return unitPrice;
    }

    // For backward compatibility
    public void setPrice(double price) {
        this.unitPrice = price;
        calculateSubtotal();
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
        if (product != null) {
            this.productId = product.getId();
            this.productName = product.getName();
            this.unitPrice = product.getPrice();
            calculateSubtotal();
        }
    }
    
    // Helper methods
    private void calculateSubtotal() {
        this.subtotal = this.quantity * this.unitPrice;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        var orderDetail = (OrderDetail) obj;
        return id == orderDetail.id && 
               orderId == orderDetail.orderId && 
               productId == orderDetail.productId;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, orderId, productId);
    }
    
    @Override
    public String toString() {
        return "OrderDetail{" +
               "orderId=" + orderId +
               ", productId=" + productId +
               ", productName='" + productName + '\'' +
               ", quantity=" + quantity +
               ", unitPrice=" + unitPrice +
               ", subtotal=" + subtotal +
               '}';
    }
}
