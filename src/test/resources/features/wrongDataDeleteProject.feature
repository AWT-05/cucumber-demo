@negative
Feature: Project Controller

Feature: Project Controller

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New Project Description |
      | Language     | python                  |
      | Project Name | New Project             |
    And I save response as "P"
    Then Validates the response has status code 200

  Scenario: Delete Project without project id
    When I send a DELETE request to "/project/delete"
    Then Validates the response has status code 405
    And Response body should match with "project/methodNotAllowedCreateProjectSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp}      |
      | status    | 405                |
      | error     | Method Not Allowed |
      | message   | {P.message}        |
      | path      | {P.path}           |