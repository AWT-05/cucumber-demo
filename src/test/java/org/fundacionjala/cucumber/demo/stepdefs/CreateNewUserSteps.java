package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;


import static org.testng.Assert.assertEquals;

public class CreateNewUserSteps {

    @Before("@Acceptance")
    public void setUp() {
        System.out.println("Before: All steps in a Scenario");
    }

    @Given("I set authentication token using admin account")
    public void authenticate() {

    }

    @When("I send a POST request to {string} with the following parameters")
    public void postRequest(String endpoint) {

    }

    @Then("II validate the response has status code 200")
    public void validateStatusCode(int statusCode) {
        assertEquals(statusCode,200);
    }

    @After("@Acceptance")
    public void endFeature() {
        System.out.println("Cleaning...");
    }
}
