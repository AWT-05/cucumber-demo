@negative
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Create a new Project with incorrect Project name parameter
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language    | csharp      |
      | ProjectName | New Project |
    And I save response as "P"
    Then Validates the response has status code 400
    And Response body should match with "project/badRequestSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |

  Scenario: Create a new Project without Project name
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language | csharp |
    And I save response as "P"
    Then Validates the response has status code 400
    And Response body should match with "project/badRequestSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |

  Scenario: Create a new Project with incorrect Language parameter
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Languag      | csharp      |
      | Project Name | New Project |
    And I save response as "P"
    Then Validates the response has status code 400
    And Response body should match with "project/badRequestSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |

  Scenario: Create a new Project without Language
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Project Name | New Project |
    And I save response as "P"
    Then Validates the response has status code 400
    And Response body should match with "project/badRequestSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 400           |
      | error     | Bad Request   |
      | message   | {P.message}   |
      | path      | {P.path}      |

  Scenario: Create a new Project without user id
    When I send a POST request to "/project/new/user" with the following parameters
      | Language     | java        |
      | Project Name | New Project |
    And I save response as "P"
    Then Validates the response has status code 404
    And Response body should match with "project/notFoundSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 404           |
      | error     | Not Found     |
      | message   | {P.message}   |
      | path      | {P.path}      |