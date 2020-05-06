package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;

import static io.restassured.RestAssured.given;

public class ProjectHooks {

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
    @After("@deleteProject")
    public void cleanProjectsData() {
        for (String id : context.getIdsForDeleting()) {
            String endPointMapped = Mapper.replaceData("/project/delete/".concat(id), context.getResponses());
            response = given(context.getReqSpec()).when().delete(endPointMapped);
        }
    }
}
