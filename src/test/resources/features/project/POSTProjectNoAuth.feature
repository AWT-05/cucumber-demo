@negative
Feature: Project Controller

  Scenario: Create Project without authentication
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Language     | csharp      |
      | Project Name | New Project |
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403                        |
      | error   | Forbidden                  |
      | message | Access Denied              |
      | path    | /api/v1/project/new/user/2 |
