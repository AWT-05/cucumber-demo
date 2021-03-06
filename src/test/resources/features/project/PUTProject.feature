@functional
Feature: Project Controller

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New Project Description |
      | Language     | python                  |
      | Project Name | New Project             |
    And I save response as "P"
    And I save "projectId" value to clean project workspace
    Then I validate the response has status code 200

  @deleteProject
  Scenario: Update existing Project
    When I send a PUT request to "/project/info/{P.projectId}" with the following parameters
      | Description  | Updated Project Description |
      | Project name | Updated Project             |
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | description    | Updated Project Description |
      | language       | PYTHON_32                   |
      | projectName    | Updated Project             |
      | user.email     | {normalUser.email}          |
      | user.firstName | {normalUser.firstName}      |
      | user.lastName  | {normalUser.lastName}       |
      | user.password  | {normalUser.password}       |
      | user.rol       | {normalUser.rol}            |
      | user.userId    | {normalUser.id}             |
      | user.userName  | {normalUser.userName}       |
