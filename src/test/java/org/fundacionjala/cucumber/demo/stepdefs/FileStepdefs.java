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

    public FileStepdefs(Context context) {
        this.context = context;
    }

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
    }
}
