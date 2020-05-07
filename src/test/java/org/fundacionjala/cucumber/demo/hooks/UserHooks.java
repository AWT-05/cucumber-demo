package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;
import org.fundacionjala.cucumber.demo.utils.Mapper;

import java.util.List;

import static io.restassured.RestAssured.given;

public class UserHooks {
    private Context context;
    private Response response;

    /**
     * Initializes an instance of UserHooks class.
     *
     * @param context scenario context object.
     */
    public UserHooks(final Context context) {
        this.context = context;
    }

    @After(@deleteUser)
    public void buildDefaultReqSpec() {
        List<String> idsToDelete = context.getIdsForDeleting();
        for (String ids: idsToDelete) {
            String endPointMapped = Mapper.replaceData("/user/delete/".concat(ids), context.getResponses());
            response = given(context.getReqSpec()).when().delete(endPointMapped);
        }
    }
}
