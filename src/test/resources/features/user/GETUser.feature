Feature: User Controller

  Background: Set authentication
    Given I set authentication token using "admin" account

  @acceptance
  Scenario: Get all users
    When I send a GET request to "/user"
    Then I validate the response has status code 200
    And I validate the response body should match with "user/getUsersResponseSchema.json" JSON schema

  @acceptance
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

  @negative
  Scenario: Get an specific user with nonexistent id
    When I send a GET request to "/user/9000"
    Then I validate the response has status code 404

  @smoke
  Scenario Outline: Get an specific user only allows numbers
    When I send a GET request to "/user/<id>"
    Then I validate the response has status code 400
    Examples:
      | id |
      | d  |
      | -  |