package org.fundacionjala.cucumber.demo.model;

public class Customer {
    private String name;
    private int refund;

    public Customer(String name) {
        this.name = name;
    }

    public void refund(int price) {
        this.refund = price;
    }

    public int getRefunded() {
        return this.refund;
    }
}
