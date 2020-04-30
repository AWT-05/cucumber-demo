package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.testng.Assert.assertEquals;

public class CustomerSteps {

    private Store store;

    public CustomerSteps(Store store) {
        this.store = store;
    }

    @When("she return the {string} to the store")
    public void sheReturnTheToTheStore(String itemType) {
        assertEquals(itemType, store.item.getItemType());
    }

    @And("she show her receipt")
    public void sheShowHerReceipt() {
        store.customer.refund(store.item.getPrice());
    }

    @Then("she will get ${int} refunded")
    public void sheWillGet$Refunded(int expected) {
        assertEquals(store.customer.getRefunded(), expected);
    }
}
