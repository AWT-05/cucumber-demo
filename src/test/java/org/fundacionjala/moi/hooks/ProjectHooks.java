package org.fundacionjala.moi.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.moi.context.Context;

import static io.restassured.RestAssured.given;

public class ProjectHooks {

    private static final int CLEAN_CONTEXT_ORDER_VALUE = 20;
    private Context context;
    private Response response;

    /**
     * Initializes an instance of ProjectHooks class.
     *
     * @param context scenario context object.
     */
    public ProjectHooks(final Context context) {
        this.context = context;
    }

    /**
     * Delete projects.
     */
    @After(value = "@deleteProject", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void cleanProjectsData() {
        context.getIdsByKey("projectId")
                .forEach(id -> response = given(context.getReqSpec()).when().delete("/project/delete/".concat(id)));
    }
}
