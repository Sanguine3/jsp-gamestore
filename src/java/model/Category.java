/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.time.LocalDateTime;
import java.util.Objects;

public class Category {
    private int id;
    private String name;
    private String description;
    private String iconUrl;
    private int displayOrder;
    private boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Category() {
    }

    // Simple constructor for backward compatibility
    public Category(int id, String name) {
        this.id = id;
        this.name = name;
        this.isActive = true;
        this.displayOrder = 0;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Full constructor
    public Category(int id, String name, String description, String iconUrl, 
                   int displayOrder, boolean isActive, 
                   LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.iconUrl = iconUrl;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getIconUrl() {
        return iconUrl;
    }
    
    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }
    
    public int getDisplayOrder() {
        return displayOrder;
    }
    
    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean isActive) {
        this.isActive = isActive;
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
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        var category = (Category) obj;
        return id == category.id && 
               Objects.equals(name, category.name);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
    
    @Override
    public String toString() {
        return "Category{" +
               "id=" + id +
               ", name='" + name + '\'' +
               "}";
    }
}
