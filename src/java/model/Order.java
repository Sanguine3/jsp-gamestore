/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Order {
    private int id;
    private String orderNumber;
    private int accountId;  // backward compatibility with uid
    private int statusId;
    private int billingAddressId;
    private int shippingAddressId;
    private int paymentMethodId;
    private double subtotal;
    private double taxAmount;
    private double shippingAmount;
    private double discountAmount;
    private double totalAmount;
    private String notes;
    private String trackingNumber;
    private String paymentTransactionId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Collection of order items
    private List<OrderDetail> orderItems = new ArrayList<>();

    public Order() {
    }

    // Simple constructor for backward compatibility
    public Order(int id, int accountId, double total) {
        this.id = id;
        this.accountId = accountId;
        this.totalAmount = total;
        this.subtotal = total;
        this.taxAmount = 0;
        this.shippingAmount = 0;
        this.discountAmount = 0;
        this.statusId = 1; // Default to "Pending"
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.orderNumber = generateOrderNumber();
    }

    // Full constructor
    public Order(int id, String orderNumber, int accountId, int statusId,
                int billingAddressId, int shippingAddressId, int paymentMethodId,
                double subtotal, double taxAmount, double shippingAmount,
                double discountAmount, double totalAmount, String notes,
                String trackingNumber, String paymentTransactionId,
                LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.orderNumber = orderNumber;
        this.accountId = accountId;
        this.statusId = statusId;
        this.billingAddressId = billingAddressId;
        this.shippingAddressId = shippingAddressId;
        this.paymentMethodId = paymentMethodId;
        this.subtotal = subtotal;
        this.taxAmount = taxAmount;
        this.shippingAmount = shippingAmount;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
        this.notes = notes;
        this.trackingNumber = trackingNumber;
        this.paymentTransactionId = paymentTransactionId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Generate an order number in format ORD-YYYYMMDD-XXXXX
    private String generateOrderNumber() {
        String datePart = String.format("%tY%<tm%<td", createdAt);
        String randomPart = String.format("%05d", id); // Pad with leading zeros
        return "ORD-" + datePart + "-" + randomPart;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getOrderNumber() {
        return orderNumber;
    }
    
    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }
    
    public int getAccountId() {
        return accountId;
    }
    
    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }
    
    // For backward compatibility
    public int getUid() {
        return accountId;
    }

    // For backward compatibility
    public void setUid(int uid) {
        this.accountId = uid;
    }
    
    public int getStatusId() {
        return statusId;
    }
    
    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }
    
    public int getBillingAddressId() {
        return billingAddressId;
    }
    
    public void setBillingAddressId(int billingAddressId) {
        this.billingAddressId = billingAddressId;
    }
    
    public int getShippingAddressId() {
        return shippingAddressId;
    }
    
    public void setShippingAddressId(int shippingAddressId) {
        this.shippingAddressId = shippingAddressId;
    }
    
    public int getPaymentMethodId() {
        return paymentMethodId;
    }
    
    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
        calculateTotal();
    }
    
    public double getTaxAmount() {
        return taxAmount;
    }
    
    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
        calculateTotal();
    }
    
    public double getShippingAmount() {
        return shippingAmount;
    }
    
    public void setShippingAmount(double shippingAmount) {
        this.shippingAmount = shippingAmount;
        calculateTotal();
    }
    
    public double getDiscountAmount() {
        return discountAmount;
    }
    
    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
        calculateTotal();
    }

    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    // For backward compatibility
    public double getTotal() {
        return totalAmount;
    }
    
    // For backward compatibility
    public void setTotal(double total) {
        this.totalAmount = total;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getTrackingNumber() {
        return trackingNumber;
    }
    
    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }
    
    public String getPaymentTransactionId() {
        return paymentTransactionId;
    }
    
    public void setPaymentTransactionId(String paymentTransactionId) {
        this.paymentTransactionId = paymentTransactionId;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public List<OrderDetail> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderDetail> orderItems) {
        this.orderItems = orderItems;
    }
    
    public void addOrderItem(OrderDetail item) {
        if (orderItems == null) {
            orderItems = new ArrayList<>();
        }
        orderItems.add(item);
        recalculateSubtotal();
    }
    
    // Helper methods
    private void calculateTotal() {
        this.totalAmount = this.subtotal + this.taxAmount + this.shippingAmount - this.discountAmount;
    }
    
    private void recalculateSubtotal() {
        if (orderItems != null) {
            this.subtotal = orderItems.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
            calculateTotal();
        }
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        var order = (Order) obj;
        return id == order.id && 
               accountId == order.accountId &&
               Objects.equals(orderNumber, order.orderNumber);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, orderNumber, accountId);
    }
    
    @Override
    public String toString() {
        return "Order{" +
               "id=" + id +
               ", orderNumber='" + orderNumber + '\'' +
               ", accountId=" + accountId +
               ", total=" + totalAmount +
               ", status=" + statusId +
               '}';
    }
}
