package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;

import static io.restassured.RestAssured.given;

public class FileHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE_FILE = 30;
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
     * Deletes created files.
     */
    @After(value = "@deleteFile", order = CLEAN_CONTEXT_ORDER_VALUE_FILE)
    public void cleanProjectsData() {
        context.getIdsByKey("fileId")
                .forEach(id -> response = given(context.getReqSpec()).when().delete("/file/".concat(id)));
    }
}
