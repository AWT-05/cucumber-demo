package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import java.io.File;

import static io.restassured.RestAssured.given;
import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import static org.testng.Assert.assertEquals;

/**
 * Groups step definitions.
 */
public class RequestSteps {

    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status code does not match actual status code.";

    private Response response;

    /**
     * Sends post request to endpoint.
     *
     * @param endpoint service endpoint.
     * @param body     request body content.
     */
    @When("I send POST request to {string} endpoint")
    public void sendPostRequest(final String endpoint, final String body) {
        response = given().header("Content-Type", "application/json")
                .when().body(body).post(endpoint);
    }

    /**
     * Validates response status code.
     *
     * @param expectedStatusCode response status code.
     */
    @Then("I validate status should be {int}")
    public void validateStatusCode(final int expectedStatusCode) {
        assertEquals(response.getStatusCode(), expectedStatusCode, STATUS_CODE_ERROR_MESSAGE);
    }

    /**
     * Validats response body json schema.
     *
     * @param schemaPath json schema path.
     */
    @Then("I validate response body should match with {string} json schema")
    public void validateJsonSchema(final String schemaPath) {
        File schemaFile = new File(schemaPath);
        response.then().assertThat().body(matchesJsonSchema(schemaFile));
    }
}
