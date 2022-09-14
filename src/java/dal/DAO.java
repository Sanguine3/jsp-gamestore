/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Cart;
import model.Category;
import model.Item;
import model.Product;


public class DAO extends DBContext {

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from Category";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Product> getAllProductByTop10() {
        List<Product> list = new ArrayList<>();
        String sql = "select top 10 p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid order by p.price desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Product> getAllProductByRating() {
        List<Product> list = new ArrayList<>();
        String sql = "select top 10 p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid order by p.rating desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getAllProductByCategoryID(String cid) {
        List<Product> list = new ArrayList<>();
        String sql = "select p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid  where c.id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Product getProductByProductID(String pid) {
        String sql = "select p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid where p.id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Product> getProductBySearchName(String search) {
        List<Product> list = new ArrayList<>();
        String sql = "select p.id, p.name, p.image, p.price, p.description, c.id as cid, c.name, p.releasedate, p.rating from Category c inner join Product p on c.id = p.cid where p.name like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + search + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(6), rs.getString(7));
                Product p = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getFloat(4), rs.getString(5), rs.getString(8), rs.getFloat(9), c);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Account login(String user, String pass) {
        String sql = "select * from Account where [user] = ? and pass = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account checkUserExist(String user) {
        String sql = "select * from Account where [user] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void signup(String user, String pass) {
        String sql = "insert into Account values(?, ?, 0)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void delete(String pid) {
        String sql = "delete from Product where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insert(String name, String image, float price, String description, int cid, String releasedate, float rating) {
        String sql = "insert into Product values(?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, image);
            st.setFloat(3, price);
            st.setString(4, description);
            st.setInt(5, cid);
            st.setString(6, releasedate);
            st.setFloat(7, rating);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void update(String name, String image, float price, String description, int cid, String releasedate, float rating, String id) {
        String sql = "update Product set name = ?, image = ?, price = ?, description = ?, cid = ?, releasedate = ?, rating = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, image);
            st.setFloat(3, price);
            st.setString(4, description);
            st.setInt(5, cid);
            st.setString(6, releasedate);
            st.setFloat(7, rating);
            st.setString(8, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateAcc(String user, String pass, int admin, int aid) {
        String sql = "update Account set [user] = ?, pass = ?, admin = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            st.setInt(3, admin);
            st.setInt(4, aid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Product> getAllProductByPage(List<Product> list, int start, int end) {
        ArrayList<Product> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void addOrder(Account a, Cart c) {
        String sql = "insert into Order values (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, a.getId());
            st.setDouble(2, c.getTotalMoney());
            st.executeUpdate();
            // lay ra id cua order vua add
            String sql1 = "select top 1 id from Order order by id desc";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            ResultSet rs = st1.executeQuery();
            //add vao bang Orderdetail
            if (rs.next()) {
                int oid = rs.getInt(1);
                for (Item i : c.getItems()) {
                    String sql2 = "insert into OrderDetail values (?,?,?,?)";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setInt(1, oid);
                    st2.setInt(2, i.getProduct().getId());
                    st2.setInt(3, i.getQuantity());
                    st2.setDouble(4, i.getPrice());
                    st2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public List<Account> getAllAccount(){
        List<Account> list = new ArrayList<>();
        String sql = "select * from Account";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getInt("id"), rs.getString("user"), rs.getString("pass"), rs.getInt("admin")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public Account getAllAccountById(String aid){
        List<Account> list = new ArrayList<>();
        String sql = "select * from Account where id=?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, aid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"), rs.getString("user"), rs.getString("pass"), rs.getInt("admin"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<Account> getAllAccountNotAdmin(){
        List<Account> list = new ArrayList<>();
        String sql = "select * from Account where id not like 1";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getInt("id"), rs.getString("user"), rs.getString("pass"), rs.getInt("admin")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void remove(String uid) {
        String sql = "delete from Account where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, uid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public List<Account> getAllAccountByPage(List<Account> list, int start, int end) {
        ArrayList<Account> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
