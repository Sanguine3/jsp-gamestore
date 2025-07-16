/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Account;
import model.Cart;
import model.Category;
import model.Item;
import model.Product;

public class DAO extends DBContext {
    private static final Logger LOGGER = Logger.getLogger(DAO.class.getName());
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM category";
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category(
                    rs.getInt("id"), 
                    rs.getString("name")
                );
                list.add(category);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving categories", e);
        }
        
        return list;
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id";
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                Product p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image_url"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    formatDate(rs.getDate("release_date")),
                    rs.getDouble("rating"),
                    c
                );
                list.add(p);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all products", e);
        }
        
        return list;
    }
    
    public List<Product> getAllProductByTop10() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id " +
                    "ORDER BY p.price DESC LIMIT 10";
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                Product p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image_url"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    formatDate(rs.getDate("release_date")),
                    rs.getDouble("rating"),
                    c
                );
                list.add(p);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving top 10 products", e);
        }
        
        return list;
    }
    
    public List<Product> getAllProductByRating() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id " +
                    "ORDER BY p.rating DESC LIMIT 10";
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                Product p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image_url"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    formatDate(rs.getDate("release_date")),
                    rs.getDouble("rating"),
                    c
                );
                list.add(p);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving products by rating", e);
        }
        
        return list;
    }

    public List<Product> getAllProductByCategoryID(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id " +
                    "WHERE c.id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, categoryId);
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                    Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        formatDate(rs.getDate("release_date")),
                        rs.getDouble("rating"),
                        c
                    );
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving products by category ID: " + categoryId, e);
        }
        
        return list;
    }
    
    // Overload for backward compatibility
    public List<Product> getAllProductByCategoryID(String categoryIdStr) {
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            return getAllProductByCategoryID(categoryId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid category ID format: " + categoryIdStr, e);
            return new ArrayList<>();
        }
    }

    public Product getProductByProductID(int productId) {
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id " +
                    "WHERE p.id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productId);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                    return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        formatDate(rs.getDate("release_date")),
                        rs.getDouble("rating"),
                        c
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving product by ID: " + productId, e);
        }
        
        return null;
    }
    
    // Overload for backward compatibility
    public Product getProductByProductID(String productIdStr) {
        try {
            int productId = Integer.parseInt(productIdStr);
            return getProductByProductID(productId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid product ID format: " + productIdStr, e);
            return null;
        }
    }

    public List<Product> getProductBySearchName(String search) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image_url, p.price, p.description, " +
                    "c.id AS category_id, c.name, p.release_date, p.rating " +
                    "FROM category c INNER JOIN product p ON c.id = p.category_id " +
                    "WHERE p.name ILIKE ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, "%" + search + "%");
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Category c = new Category(rs.getInt("category_id"), rs.getString("name"));
                    Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        formatDate(rs.getDate("release_date")),
                        rs.getDouble("rating"),
                        c
                    );
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching products by name: " + search, e);
        }
        
        return list;
    }

    public Account login(String username, String password) {
        String sql = "SELECT * FROM account WHERE username = ? AND pass = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getInt("role_id") // Updated to match new schema
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during login attempt for user: " + username, e);
        }
        
        return null;
    }

    public Account checkUserExist(String username) {
        String sql = "SELECT * FROM account WHERE username = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getInt("role_id") // Updated to match new schema
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking if user exists: " + username, e);
        }
        
        return null;
    }

    public void signup(String username, String password) {
        String sql = "INSERT INTO account (username, pass, role_id) VALUES(?, ?, 2)"; // 2 for regular user role
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error during signup for user: " + username, e);
        }
    }

    public void delete(int productId) {
        String sql = "DELETE FROM product WHERE id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productId);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting product with ID: " + productId, e);
        }
    }
    
    // Overload for backward compatibility
    public void delete(String productIdStr) {
        try {
            int productId = Integer.parseInt(productIdStr);
            delete(productId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid product ID format for deletion: " + productIdStr, e);
        }
    }

    public void insert(String name, String imageUrl, double price, String description, 
                      int categoryId, String releaseDate, double rating) {
        String sql = "INSERT INTO product (name, image_url, price, description, category_id, release_date, rating) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, name);
            st.setString(2, imageUrl);
            st.setDouble(3, price);
            st.setString(4, description);
            st.setInt(5, categoryId);
            st.setDate(6, java.sql.Date.valueOf(parseDate(releaseDate)));
            st.setDouble(7, rating);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting product: " + name, e);
        }
    }

    public void update(String name, String imageUrl, double price, String description, 
                      int categoryId, String releaseDate, double rating, int productId) {
        String sql = "UPDATE product SET name = ?, image_url = ?, price = ?, description = ?, " +
                    "category_id = ?, release_date = ?, rating = ? WHERE id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, name);
            st.setString(2, imageUrl);
            st.setDouble(3, price);
            st.setString(4, description);
            st.setInt(5, categoryId);
            st.setDate(6, java.sql.Date.valueOf(parseDate(releaseDate)));
            st.setDouble(7, rating);
            st.setInt(8, productId);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product with ID: " + productId, e);
        }
    }
    
    // Overload for backward compatibility
    public void update(String name, String imageUrl, float price, String description, 
                      int categoryId, String releaseDate, float rating, String productIdStr) {
        try {
            int productId = Integer.parseInt(productIdStr);
            update(name, imageUrl, (double)price, description, categoryId, releaseDate, (double)rating, productId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid product ID format for update: " + productIdStr, e);
        }
    }
    
    public void updateAccount(String username, String password, int roleId, int accountId) {
        String sql = "UPDATE account SET username = ?, pass = ?, role_id = ? WHERE id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, roleId);
            st.setInt(4, accountId);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating account with ID: " + accountId, e);
        }
    }
    
    // For backward compatibility
    public void updateAcc(String username, String password, int adminLevel, int accountId) {
        updateAccount(username, password, adminLevel, accountId);
    }

    // Get products by page using Java 11 streams
    public List<Product> getAllProductByPage(List<Product> list, int start, int end) {
        return list.stream()
                   .skip(start)
                   .limit(end - start)
                   .collect(Collectors.toList());
    }

    public void addOrder(Account account, Cart cart) {
        try {
            // Insert into orders table
            String sql = "INSERT INTO orders (account_id, total_amount) VALUES (?, ?)";
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, account.getId());
            st.setDouble(2, cart.getTotalMoney());
            st.executeUpdate();
            
            // Get the generated order ID
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                
                // Insert into order_item table
                for (Item item : cart.getItems()) {
                    String sql2 = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setInt(1, orderId);
                    st2.setInt(2, item.getProduct().getId());
                    st2.setInt(3, item.getQuantity());
                    st2.setDouble(4, item.getPrice());
                    st2.executeUpdate();
                    st2.close();
                }
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding order for account ID: " + account.getId(), e);
        }
    }
    
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account";
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Account account = new Account(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("pass"),
                    rs.getInt("role_id") // Updated to match new schema
                );
                list.add(account);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all accounts", e);
        }
        
        return list;
    }
    
    // For backward compatibility
    public List<Account> getAllAccount() {
        return getAllAccounts();
    }
    
    public Account getAccountById(int accountId) {
        String sql = "SELECT * FROM account WHERE id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, accountId);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getInt("role_id") // Updated to match new schema
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving account by ID: " + accountId, e);
        }
        
        return null;
    }
    
    // For backward compatibility
    public Account getAllAccountById(String accountIdStr) {
        try {
            int accountId = Integer.parseInt(accountIdStr);
            return getAccountById(accountId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid account ID format: " + accountIdStr, e);
            return null;
        }
    }
    
    public List<Account> getNonAdminAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account WHERE role_id != 1"; // 1 is admin role
        
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Account account = new Account(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("pass"),
                    rs.getInt("role_id")
                );
                list.add(account);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving non-admin accounts", e);
        }
        
        return list;
    }
    
    // For backward compatibility
    public List<Account> getAllAccountNotAdmin() {
        return getNonAdminAccounts();
    }
    
    public void removeAccount(int accountId) {
        String sql = "DELETE FROM account WHERE id = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, accountId);
            st.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error removing account with ID: " + accountId, e);
        }
    }
    
    // For backward compatibility
    public void remove(String accountIdStr) {
        try {
            int accountId = Integer.parseInt(accountIdStr);
            removeAccount(accountId);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid account ID format for removal: " + accountIdStr, e);
        }
    }
    
    public List<Account> getAllAccountByPage(List<Account> list, int start, int end) {
        return list.stream()
                  .skip(start)
                  .limit(end - start)
                  .collect(Collectors.toList());
    }
    
    // Helper method to format java.sql.Date to string
    private String formatDate(java.sql.Date date) {
        if (date == null) return "";
        return date.toLocalDate().format(DATE_FORMATTER);
    }
    
    // Helper method to parse string date to LocalDate
    private LocalDate parseDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return LocalDate.now();
        }
        try {
            return LocalDate.parse(dateStr, DATE_FORMATTER);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error parsing date: " + dateStr, e);
            return LocalDate.now();
        }
    }
}

