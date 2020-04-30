package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.fundacionjala.cucumber.demo.model.Customer;
import org.fundacionjala.cucumber.demo.model.Item;

import static org.testng.Assert.assertEquals;

public class BrokenItemsStepdefs {

    /*private Customer customer;
    private Item item;

    @Given("that {string} bought a faulty {string} for ${int}")
    public void thatBoughtAFaultyFor$(String name, String itemType, int price) {
        customer = new Customer(name);
        item = new Item(itemType, price);
    }

    @When("she return the {string} to the store")
    public void sheReturnTheToTheStore(String itemType) {
        assertEquals(itemType, item.getItemType());
    }

    @And("she show her receipt")
    public void sheShowHerReceipt() {
        customer.refund(item.getPrice());
    }

    @Then("she will get ${int} refunded")
    public void sheWillGet$Refunded(int expected) {
        assertEquals(customer.getRefunded(), expected);
    }
*/
}
