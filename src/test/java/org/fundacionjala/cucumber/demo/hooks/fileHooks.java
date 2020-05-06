package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;

import static io.restassured.RestAssured.given;

public class fileHooks {
    private final Context context;
    private Response response;

    public fileHooks(final Context context) {
        this.context = context;
    }

    /**
     * Delete a file created.
     */
    @After("@deleteFile")
    public void buildDefaultReqSpec() {
        String idFile = context.getIDs().get("fileId").toString();
        String endpointMapped = Mapper.replaceData("/file/".concat(idFile), context.getResponses());
        response = given(context.getReqSpec()).when().delete(endpointMapped);
    }
}
