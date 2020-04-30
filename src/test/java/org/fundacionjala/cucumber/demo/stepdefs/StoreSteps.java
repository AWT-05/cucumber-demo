package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.Given;
import org.fundacionjala.cucumber.demo.model.Customer;
import org.fundacionjala.cucumber.demo.model.Item;

public class StoreSteps {

    private Store store;

    public StoreSteps(Store store) {
        this.store = store;
    }

    @Given("that {string} bought a faulty {string} for ${int}")
    public void thatBoughtAFaultyFor$(String name, String itemType, int price) {
        store.customer = new Customer(name);
        store.item = new Item(itemType, price);
    }
}
