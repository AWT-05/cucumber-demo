@negative
Feature: Project Controller

Feature: Project Controller

  Scenario: Delete Project without project id
    When I send a DELETE request to "/project/delete"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp}      |
      | status    | 405                |
      | error     | Method Not Allowed |
      | message   | {P.message}        |
      | path      | {P.path}           |