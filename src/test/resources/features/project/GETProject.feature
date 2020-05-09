@acceptance
Feature: Project Controller

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New Project Description |
      | Language     | java                    |
      | Project Name | New Project             |
    And I save response as "P"
    And I save "projectId" value to clean project workspace
    Then I validate the response has status code 200

  @deleteProject
  Scenario: Read existing Project
    When I send a GET request to "/project/{P.projectId}"
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | description    | New Project Description |
      | language       | JAVA                    |
      | projectName    | New Project             |
      | user.email     | {normalUser.email}      |
      | user.firstName | {normalUser.firstName}  |
      | user.lastName  | {normalUser.lastName}   |
      | user.password  | {normalUser.password}   |
      | user.rol       | {normalUser.rol}        |
      | user.userId    | {normalUser.id}         |
      | user.userName  | {normalUser.userName}   |

  @deleteProject
  Scenario: Read all Projects
    When I send a GET request to "/project"
    Then I validate the response has status code 200
