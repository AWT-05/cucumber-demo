package org.fundacionjala.cucumber.demo.context;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

/**
 * Repository class to store and share data among step definitions.
 */
public class Context {

    private RequestSpecification reqSpec;
    private Map<String, Response> responses;
    private Queue<String> queueIds;

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
        queueIds = new LinkedList<>();
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
     * Gets context responses.
     *
     * @return context responses.
     */
    public Map<String, Response> getResponses() {
        return responses;
    }

    /**
     * Saves id value in the context.
     *
     * @param value id.
     */
    public void saveIDs(final String value) {
        queueIds.add(value);
    }


    /**
     * Gets context ids.
     *
     * @return context ids.
     */
    public Queue<String> getIDs() {
        return queueIds;
    }
}
