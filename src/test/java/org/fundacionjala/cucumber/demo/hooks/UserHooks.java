package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import static io.restassured.RestAssured.given;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;

public class UserHooks {
    private static final int CLEAN_CONTEXT_ORDER_VALUE = 10;
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

    @After(value = "@deleteUser", order = CLEAN_CONTEXT_ORDER_VALUE)
    public void createUserForDeletion() {
        for (String id : context.getIdsByKey("userId")) {
            response = given(context.getReqSpec()).when().delete("/user/delete/".concat(id));
        }
    }
}
