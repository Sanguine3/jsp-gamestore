/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Objects;

public class Account {
    private int id;
    private String username; // Changed from user to username
    private String pass;
    private int adminLevel; // Changed from admin to adminLevel for clarity

    public Account() {
    }

    public Account(int id, String username, String pass, int adminLevel) {
        this.id = id;
        this.username = username;
        this.pass = pass;
        this.adminLevel = adminLevel;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    // For backward compatibility
    public String getUser() {
        return username;
    }
    
    public void setUser(String user) {
        this.username = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(int adminLevel) {
        this.adminLevel = adminLevel;
    }

    // For backward compatibility
    public int getAdmin() {
        return adminLevel;
    }
    
    public void setAdmin(int admin) {
        this.adminLevel = admin;
    }
    
    // Added Java 11 equals and hashCode
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        var account = (Account) obj;
        return id == account.id && 
               adminLevel == account.adminLevel &&
               Objects.equals(username, account.username) &&
               Objects.equals(pass, account.pass);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, username, pass, adminLevel);
    }
    
    @Override
    public String toString() {
        return "Account{" +
               "id=" + id +
               ", username='" + username + '\'' +
               ", adminLevel=" + adminLevel +
               '}';
    }
}
