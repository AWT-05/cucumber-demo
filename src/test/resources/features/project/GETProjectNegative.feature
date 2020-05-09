@negative
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Read non existing Project
    When I send a GET request to "/project/400"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 404                 |
      | error   | Not Found           |
      | message | No value present    |
      | path    | /api/v1/project/400 |
