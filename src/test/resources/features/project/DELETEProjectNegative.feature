@negative
Feature: Project Controller

  Scenario: Delete Project without project id
    When I send a DELETE request to "/project/delete"
    And I save response as "P"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 404           |
      | error     | Not Found     |
      | message   | {P.message}   |
      | path      | {P.path}      |