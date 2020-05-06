@negative
Feature: Project Controller

  Scenario: Read all Projects without Auntentication
    When I send a GET request to "/project"
    And I save response as "P"
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 403           |
      | error     | Forbidden     |
      | message   | Access Denied |
      | path      | {P.path}      |