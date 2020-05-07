package org.fundacionjala.cucumber.demo.hooks;

import io.cucumber.java.After;
import io.restassured.response.Response;
import org.fundacionjala.cucumber.demo.context.Context;

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

    @After(value = "@deleteUser", order = 0)
    public void createUserForDeletion() {

    }
}
