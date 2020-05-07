package org.fundacionjala.cucumber.demo.context;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Repository class to store and share data among step definitions.
 */
public class Context {

    private RequestSpecification reqSpec;
    private Map<String, Response> responses;
    private List<String> ids;

    /**
     * Initializes an instance of Context class.
     */
    public Context() {
        initializeValues();
    }

    /**
     * Initializes context values.
     */
    public void initializeValues() {
        reqSpec = null;
        responses = new HashMap<>();

        ids = new ArrayList<>();
    }

    /**
     * Sets request specification.
     *
     * @param reqSpec request specification.
     */
    public void setReqSpec(final RequestSpecification reqSpec) {
        this.reqSpec = reqSpec;
    }

    /**
     * Gets request specification.
     *
     * @return request specification.
     */
    public RequestSpecification getReqSpec() {
        return reqSpec;
    }

    /**
     * Saves response according to key.
     *
     * @param key      key identifier.
     * @param response response object.
     */
    public void saveResponse(final String key, final Response response) {
        responses.put(key, response);
    }

    /**
     * Saves ids in a list .
     *
     * @param id      project id.
     */
    public void saveIdsForDeleting(final String id) {
        ids.add(id);
    }

    /**
     * Gets saved list .
     *
     * @return  id      project id.
     */
    public List<String> getIdsForDeleting() {
        return ids;
    }

    /**
     * Gets context responses.
     *
     * @return context responses.
     */
    public Map<String, Response> getResponses() {
        return responses;
    }
}
