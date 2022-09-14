/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;


public class Cart {

    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public Cart(List<Item> items) {
        this.items = items;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    // lay item
    private Item getItemByID(int id) {
        for (Item i : items) {
            if (i.getProduct().getId() == id) {
                return i;
            }
        }
        return null;
    }

    // mua them tim san trong gio hang
    public int getQuantityByID(int id) {
        return getItemByID(id).getQuantity();
    }

    public void addItem(Item t) {
        // san pham co san
        if (getItemByID(t.getProduct().getId()) != null) {
            Item m = getItemByID(t.getProduct().getId());
            m.setQuantity(m.getQuantity() + t.getQuantity());
        } // neu san pham chua co thi add vao list
        else {
            items.add(t);
        }
    }

    public void removeItem(int id) {
        // neu san pham co trong gio hang
        if (getItemByID(id) != null) {
            //xoa
            items.remove(getItemByID(id));
        }
    }

    // tong so tien
    public float getTotalMoney() {
        float t = 0;
        for (Item i : items) {
            t += i.getQuantity() * i.getProduct().getPrice();
        }
        return t;
    }
}
