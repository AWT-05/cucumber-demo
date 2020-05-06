package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;

import static io.restassured.RestAssured.given;

public class FileHooks {

    private final Context context;
    private Response response;

    /**
     * Initializes an instance of FileHooks class.
     *
     * @param context scenario context object.
     */
    public FileHooks(final Context context) {
        this.context = context;
    }

    /**
     * Deletes the created files.
     */
    @After("@deleteFile")
    public void buildDefaultReqSpec() {
        String idFile = context.getIDs().peek();
        String endpointMapped = Mapper.replaceData("/file/".concat(idFile), context.getResponses());
        response = given(context.getReqSpec()).when().delete(endpointMapped);
    }
}
