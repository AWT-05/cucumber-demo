Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Create a new java Project
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New java Project Description |
      | Language     | java                         |
      | Project Name | New java Project             |
    And I save response as "P"
    Then I validate the response has status code 200
    And I validate the response body should match with "project/createJavaProjectSchema.json" JSON schema
    And I validate the response contains the following data
      | projectId      | {P.projectId}                                                                  |
      | description    | New java Project Description                                                   |
      | language       | JAVA                                                                           |
      | projectName    | New java Project                                                               |
      | path           | {projectSourcePath}/user_{normalUser.id}_projects/{P.language}/{P.projectName} |
      | user.email     | {normalUser.email}                                                             |
      | user.firstName | {normalUser.firstName}                                                         |
      | user.lastName  | {normalUser.lastName}                                                          |
      | user.password  | {normalUser.password}                                                          |
      | user.rol       | {normalUser.rol}                                                               |
      | user.userId    | {normalUser.id}                                                                |
      | user.userName  | {normalUser.userName}                                                          |
