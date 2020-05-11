package org.fundacionjala.moi.stepdefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.fundacionjala.moi.context.Context;
import org.fundacionjala.moi.utils.IRequestManager;
import org.fundacionjala.moi.utils.Mapper;

import java.io.File;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import static org.testng.Assert.assertEquals;

/**
 * Groups request step definitions.
 */
public class RequestSteps {

    private static final String SCHEMAS_BASE_FOLDER = "src/test/resources/schemas/";
    private static final String STATUS_CODE_ERROR_MESSAGE = "Expected status codeuser "
            + "does not match actual status code.";
    private static final String DATA_MATCH_ERROR_MSG = "The '%s' field does not match with expected value.";

    private final Context context;
    private Response response;
    private final IRequestManager requestManager;

    /**
     * Initializes an instance of RequestSteps class.
     *
     * @param context        scenario context.
     * @param requestManager helper to sending requests.
     */
    public RequestSteps(final Context context, final IRequestManager requestManager) {
        this.context = context;
        this.requestManager = requestManager;
    }

    /**
     * Sets authentication header to base request specification.
     *
     * @param username account username.
     */
    @Given("I set authentication token using {string} account")
    public void setAuthenticationToken(final String username) {
        requestManager.withAuthentication(username);
    }

    /**
     * Sets base request specification without authentication.
     */
    @When("I don't set authentication token")
    public void withoutAuthenticationToken() {
        requestManager.withoutAuthentication();
    }

    /**
     * Sends GET request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a GET request to {string}")
    public void sendGETRequestWithParameters(final String endpoint) {
        response = requestManager.get(endpoint);
    }

    /**
     * Sends DELETE request.
     *
     * @param endpoint resource endpoint.
     */
    @When("I send a DELETE request to {string}")
    public void sendDELETERequestWithParameters(final String endpoint) {
        response = requestManager.delete(endpoint);
    }

    /**
     * Sends POST request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a POST request to {string} with the following parameters")
    public void sendPOSTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.params(params).post(endpoint);
    }

    /**
     * Sends PUT request with parameters.
     *
     * @param endpoint resource endpoint.
     * @param params   request parameters.
     */
    @When("I send a PUT request to {string} with the following parameters")
    public void sendPUTRequestWithParameters(final String endpoint, final Map<String, String> params) {
        response = requestManager.params(params).put(endpoint);
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
     * Saves the id in a map.
     *
     * @param key expected data.
     */
    @And("I save {string} value to clean (project)(user)(file) workspace")
    public void iSaveIdValueToCleanWorkSpace(final String key) {
        String idValue = response.jsonPath().getString(key);
        context.saveIds(key, idValue);
    }
}
