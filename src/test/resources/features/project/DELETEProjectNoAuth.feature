@negative
Feature: Project Controller

  Scenario: Delete Project without authentication
    Given I don't set authentication token
    When I send a DELETE request to "/project/delete"
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403                    |
      | error   | Forbidden              |
      | message | Access Denied          |
      | path    | /api/v1/project/delete |
