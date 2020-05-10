package org.fundacionjala.cucumber.demo.utils;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.cucumber.demo.config.Environment;

import java.util.Map;

import static io.restassured.RestAssured.given;

/**
 * Groups utility methods to build request spec base object.
 */
public final class RequestSpecUtils {

    private static final String AUTHORIZATION_HEADER = "Authorization";
    private static final String TOKEN_JSON_PATH = "jwt";
    private static final String AUTHENTICATE_ENDPOINT = "/authenticate";
    private static final String AUTH_BODY = "{\"password\":\"%s\",\"username\":\"%s\"}";
    private static final String USER_NAME = "userName";
    private static final String PASSWORD = "password";
    private static final String BEARER = "Bearer ";

    /**
     * Private constructor for RequestSpecUtils utility class.
     */
    private RequestSpecUtils() {

    }

    /**
     * Builds base request specification for a username.
     *
     * @param username account username.
     * @return base request specification.
     */
    public static RequestSpecification build(final String username) {
        String baseUri = Environment.getInstance().getBaseUri();
        Map<String, String> account = Environment.getInstance().getAccount(username);
        Response authRes = given()
                .contentType(ContentType.JSON)
                .baseUri(baseUri)
                .when()
                .body(String.format(AUTH_BODY, account.get(PASSWORD), account.get(USER_NAME)))
                .post(AUTHENTICATE_ENDPOINT);
        return new RequestSpecBuilder().setBaseUri(baseUri)
                .addHeader(AUTHORIZATION_HEADER, BEARER.concat(authRes.jsonPath().getString(TOKEN_JSON_PATH))).build();
    }

    /**
     * Builds base request specification without authentication header.
     *
     * @return base request specification.
     */
    public static RequestSpecification build() {
        String baseUri = Environment.getInstance().getBaseUri();
        return new RequestSpecBuilder().setBaseUri(baseUri).build();
    }
}
