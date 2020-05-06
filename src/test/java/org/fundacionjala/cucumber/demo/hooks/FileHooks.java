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
    @After(value = "@deleteFile", order = 2)
    public void deleteFile() {
        String idFile = context.getIDs().remove();
        response = given(context.getReqSpec()).when().delete("/file/".concat(idFile));
    }

    @After(value = "@deleteProject", order = 1)
    public void deleteFolder() {
        String idProject = context.getIDs().remove();
        response = given(context.getReqSpec()).when().delete("/project/delete/".concat(idProject));
    }
}
