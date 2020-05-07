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

}
