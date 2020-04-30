package org.fundacionjala.cucumber.demo.model;

public class Item {
    private String itemType;
    private int price;

    public Item(String itemType, int price) {
        this.itemType = itemType;
        this.price = price;
    }

    public int getPrice() {
        return this.price;
    }

    public String getItemType() {
        return itemType;
    }
}
