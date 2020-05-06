@negative
Feature: Project Controller

  Scenario: Update Project with incorrect Project name parameter
    When I send a PUT request to "/project/info/{P.projectId}" with the following parameters
      | Project Name | Updated Project |
      | Description  | Updated Project |
    And I save response as "P"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |

  Scenario: Update a Project without Project id
    When I send a PUT request to "/project/info" with the following parameters
      | Project Name | Updated Project |
    And I save response as "P"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp}      |
      | status    | 405                |
      | error     | Method Not Allowed |
      | message   | {P.message}        |
      | path      | {P.path}           |