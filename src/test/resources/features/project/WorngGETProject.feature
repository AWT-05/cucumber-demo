@negative
Feature: Project Controller

  Scenario: Read non existing Project
    When I send a GET request to "/project/200"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 404           |
      | error     | Not Found     |
      | message   | {P.message}   |
      | path      | {P.path}      |