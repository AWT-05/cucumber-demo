package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;
import org.fundacionjala.cucumber.demo.utils.RequestSpecUtils;

import java.io.File;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import static org.testng.Assert.assertEquals;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private static final String SCHEMAS_BASE_FOLDER = "src/test/resources/schemas/";
    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status code does not match actual status code.";
    private static final String DATA_MATCH_ERROR_MSG = "The '%s' field does not match with expected value.";

    private Context context;
    private Response response;

    /**
     * Initializes an instance of RequestSteps class.
     *
     * @param context scenario context.
     */
    public RequestSteps(final Context context) {
        this.context = context;
    }

    /**
     * Sets authentication header to base request specification.
     *
     * @param username account username.
     */
    @Given("I set authentication token using {string} account")
    public void setAuthenticationToken(final String username) {
        RequestSpecification reqSpec = RequestSpecUtils.build(username);
        context.setReqSpec(reqSpec);
    }

    /**
     * Sends GET request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a GET request to {string}")
    public void sendGETRequestWithParameters(final String endpoint) {
        String endpointMapped = Mapper.replaceData(endpoint, context.getResponses());
        response = given(context.getReqSpec()).when().get(endpointMapped);
    }

    /**
     * Sends DELETE request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a DELETE request to {string}")
    public void sendDELETERequestWithParameters(final String endpoint) {
        String endpointMapped = Mapper.replaceData(endpoint, context.getResponses());
        response = given(context.getReqSpec()).when().delete(endpointMapped);
    }

    /**
     * Sends POST request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a POST request to {string} with the following parameters")
    public void sendPOSTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        String endpointMapped = Mapper.replaceData(endpoint, context.getResponses());
        Map<String, String> requestData = Mapper.replaceData(params, context.getResponses());
        response = given(context.getReqSpec()).params(requestData).when().post(endpointMapped);
    }

    /**
     * Sends PUT request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a PUT request to {string} with the following parameters")
    public void sendPUTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        String endpointMapped = Mapper.replaceData(endpoint, context.getResponses());
        Map<String, String> requestData = Mapper.replaceData(params, context.getResponses());
        response = given(context.getReqSpec()).params(requestData).when().put(endpointMapped);
    }

    /**
     * Saves response to context.
     *
     * @param key key identifier.
     */
    @When("I save response as {string}")
    public void saveResponseAs(final String key) {
        context.saveResponse(key, response);
    }

    /**
     * Validates response status code.
     *
     * @param expectedStatusCode response status code.
     */
    @Then("I validate the response has status code {int}")
    public void validateStatusCode(final int expectedStatusCode) {
        assertEquals(response.getStatusCode(), expectedStatusCode, STATUS_CODE_ERROR_MESSAGE);
    }

    /**
     * Validats response body json schema.
     *
     * @param schemaPath json schema path.
     */
    @Then("I validate the response body should match with {string} JSON schema")
    public void validateJsonSchema(final String schemaPath) {
        File schemaFile = new File(SCHEMAS_BASE_FOLDER.concat(schemaPath));
        response.then().assertThat().body(matchesJsonSchema(schemaFile));
    }

    /**
     * Validates that response contains expected data.
     *
     * @param data expected data.
     */
    @Then("I validate the response contains the following data")
    public void validateResponseContainsData(final Map<String, String> data) {
        Map<String, String> expectedData = Mapper.replaceData(data, context.getResponses());
        for (String key : data.keySet()) {
            assertEquals(response.jsonPath().getString(key), expectedData.get(key),
                    String.format(DATA_MATCH_ERROR_MSG, key));
        }
    }

    /**
     * Save value of the key passed.
     *
     * @param jsonKey identifier to look for.
     */
    @And("I save the {string} value")
    public void saveValue(String jsonKey) {
        String value = response.jsonPath().getString(jsonKey);
        context.saveIDs(value);
    }
}
