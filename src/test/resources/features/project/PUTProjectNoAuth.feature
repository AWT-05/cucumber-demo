@negative
Feature: Project Controller

  Scenario: Update Project without authentication
    When I send a PUT request to "/project/info/3" with the following parameters
      | ProjectName | Updated Project |
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403                    |
      | error   | Forbidden              |
      | message | Access Denied          |
      | path    | /api/v1/project/info/3 |