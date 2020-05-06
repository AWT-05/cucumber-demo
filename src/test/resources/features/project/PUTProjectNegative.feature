@negative
Feature: Project Controller

#  @deleteProject
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
      | Projectname | Updated Project |
      | Description | Updated Project |
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

  Scenario: Update Project without setting Description
    When I send a PUT request to "/project/info/{P.projectId}" with the following parameters
      | Project name | Updated Project |
    Then I validate the response has status code 200
    And I validate the response body should match with "project/projectSchema.json" JSON schema
    And I validate the response contains the following data
      | projectId      | {P.projectId}           |
      | description    | New Project Description |
      | language       | PYTHON_32               |
      | projectName    | Updated Project         |
      | user.email     | {normalUser.email}      |
      | user.firstName | {normalUser.firstName}  |
      | user.lastName  | {normalUser.lastName}   |
      | user.password  | {normalUser.password}   |
      | user.rol       | {normalUser.rol}        |
      | user.userId    | {normalUser.id}         |
      | user.userName  | {normalUser.userName}   |

  Scenario: Update Project with non exiting project id
    When I send a PUT request to "/project/info/200" with the following parameters
      | Project name | Updated Project |
      | Description  | Updated Project |
    And I save response as "P"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 404           |
      | error     | Not Found     |
      | message   | {P.message}   |
      | path      | {P.path}      |