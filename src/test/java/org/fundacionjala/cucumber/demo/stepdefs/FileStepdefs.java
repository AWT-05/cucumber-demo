package org.fundacionjala.cucumber.demo.stepdefs;

import io.cucumber.java.en.And;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;

import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class FileStepdefs {

    private Context context;
    private Response response;

    /**
     * Initializes an instance of FileStepdefs class.
     *
     * @param context scenario context.
     */
    public FileStepdefs(Context context) {
        this.context = context;
    }

    /**
     * Helper to save a default project.
     *
     * @param username account username.
     * @param language project language.
     * @param key identifier to look for.
     */
    @And("as {string} I have a project created of {string} type and save response as {string}")
    public void haveProjectCreated(String username, String language, String key) {
        String endpointMapped = Mapper
                .replaceData("/project/new/user/{".concat(username).concat(".id}"),
                        context.getResponses());
        Map<String, String> requestData = new HashMap<>(){{
            put("Language", language);
            put("Project Name", "MyProject");
        }};
        response = given(context.getReqSpec()).params(requestData).when().post(endpointMapped);

        context.saveResponse(key, response);
        String projectId = response.jsonPath().getString("projectId");
        context.saveIDs(projectId);
    }

    @And("I have a {string} created in response saved")
    public void haveFileCreated(String file) {
        String projectId = context.getIDs().remove();
        String endpointMapped = "file/new/project/".concat(projectId);
        Map<String, String> requestData = new HashMap<>(){{
            put("Code", "cHl0aG9uQ29kZUJhc2U2NA==");
            put("File Name", "MainClass");
        }};
        response = given(context.getReqSpec()).params(requestData).when().post(endpointMapped);

        context.saveResponse(file, response);
        String fileId = response.jsonPath().getString("fileId");

        context.saveIDs(fileId);
        context.saveIDs(projectId);
    }
}
