@acceptance
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  @deleteProject
  Scenario: Create a csharp Project
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New csharp Project Description |
      | Language     | csharp                         |
      | Project Name | New csharp Project             |
    And I save "projectId" value to clean project workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | description    | New csharp Project Description |
      | language       | CSHARP                         |
      | projectName    | New csharp Project             |
      | user.email     | {normalUser.email}             |
      | user.firstName | {normalUser.firstName}         |
      | user.lastName  | {normalUser.lastName}          |
      | user.password  | {normalUser.password}          |
      | user.rol       | {normalUser.rol}               |
      | user.userId    | {normalUser.id}                |
      | user.userName  | {normalUser.userName}          |

  @deleteProject
  Scenario: Create a java Project
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New java Project Description |
      | Language     | java                         |
      | Project Name | New java Project             |
    And I save "projectId" value to clean project workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | description    | New java Project Description |
      | language       | JAVA                         |
      | projectName    | New java Project             |
      | user.email     | {normalUser.email}           |
      | user.firstName | {normalUser.firstName}       |
      | user.lastName  | {normalUser.lastName}        |
      | user.password  | {normalUser.password}        |
      | user.rol       | {normalUser.rol}             |
      | user.userId    | {normalUser.id}              |
      | user.userName  | {normalUser.userName}        |

  @deleteProject
  Scenario: Create a python Project
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New python Project Description |
      | Language     | python                         |
      | Project Name | New python Project             |
    And I save "projectId" value to clean project workspace
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | description    | New python Project Description |
      | language       | PYTHON_32                      |
      | projectName    | New python Project             |
      | user.email     | {normalUser.email}             |
      | user.firstName | {normalUser.firstName}         |
      | user.lastName  | {normalUser.lastName}          |
      | user.password  | {normalUser.password}          |
      | user.rol       | {normalUser.rol}               |
      | user.userId    | {normalUser.id}                |
      | user.userName  | {normalUser.userName}          |
