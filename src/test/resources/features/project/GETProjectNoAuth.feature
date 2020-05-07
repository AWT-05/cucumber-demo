@negative
Feature: Project Controller

  Scenario: Read all Projects without authentication
    When I send a GET request to "/project"
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403             |
      | error   | Forbidden       |
      | message | Access Denied   |
      | path    | /api/v1/project |