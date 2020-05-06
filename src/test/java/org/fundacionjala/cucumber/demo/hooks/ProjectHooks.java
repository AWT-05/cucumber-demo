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
    @After(value = "@deleteProject", order = 20)
    public void cleanProjectsData() {
        for (String id : context.getIdsByKey("projectId")) {
            response = given(context.getReqSpec()).when().delete("/project/delete/".concat(id));
        }
    }
}
