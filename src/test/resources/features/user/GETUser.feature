Feature: User information

  Background: Set authentication
    Given I set authentication token using "admin" account

  Scenario: Get all users
    When I send a GET request to "/user"
    Then I validate the response has status code 200
    And I validate the response body should match with "user/getUsersResponseSchema.json" JSON schema

  Scenario: Get an specific user
    When I send a GET request to "/user/{normalUser.id}"
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | {normalUser.id}        |
      | firstName | {normalUser.firstName} |
      | lastName  | {normalUser.lastName}  |
      | userName  | {normalUser.userName}  |
      | password  | {normalUser.password}  |
      | email     | {normalUser.email}     |
      | rol       | {normalUser.rol}       |
