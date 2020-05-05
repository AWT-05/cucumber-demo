@NegativeTest
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Create a new Project with incorrect data
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language    | csharp      |
      | ProjectName | New Project |
    And I save response as "P"
    Then I validate the response has status code 400
    And Response body should match with "project/wrongDataCreateProjectSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |
