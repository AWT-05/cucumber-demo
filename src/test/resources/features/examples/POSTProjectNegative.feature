Feature: Project Controller

  Scenario: Create a java Project without authentication
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Description  | New java Project Description |
      | Language     | java                         |
      | Project Name | New java Project             |
    Then I validate the response has status code 403
    And I validate the response contains the following data
      | status  | 403                        |
      | error   | Forbidden                  |
      | message | Access Denied              |
      | path    | /api/v1/project/new/user/2 |
