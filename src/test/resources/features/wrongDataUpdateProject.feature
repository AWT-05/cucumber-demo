@NegativeTest
Feature: Project Controller

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New Project Description |
      | Language     | python                  |
      | Project Name | New Project             |
    And I save response as "P"
    Then I validate the response has status code 200

  Scenario: Update Project with incorrect Project name parameter
    When I send a PUT request to "/project/info/{P.projectId}" with the following parameters
      | ProjectName | Updated Project |
    And I save response as "P"
    Then Validates the response has status code 400
    And Response body should match with "project/badRequestSchema.json" JSON schema
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
    Then Validates the response has status code 405
    And Response body should match with "project/methodNotAllowedCreateProjectSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp}      |
      | status    | 405                |
      | error     | Method Not Allowed |
      | message   | {P.message}        |
      | path      | {P.path}           |