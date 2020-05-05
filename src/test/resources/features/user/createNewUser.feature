Feature: Create a new user un MOI

  Background: Set authentication
    Given I set authentication token using admin account

  Scenario: Create a new user
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio        |
      | Last Name  | Oroza          |
      | Password   | 1234        |
      | Username   | mau         |
    Then I validate the response has status code 200
    And Response body should match with "user/createUserResponseSchema.json" JSON schema
    And I validate the response contains the following data
      |  | Mauricio        |
      | firstNamelastName  | Oroza          |
      | userName  | mau         |
      | password  | 1234        |
      | email     | mail@mail.com |
      | rol       | user          |