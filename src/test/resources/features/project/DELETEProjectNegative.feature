@negative
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Delete Project without project id
    When I send a DELETE request to "/project/delete/"
    And I save response as "P"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp}      |
      | status    | 405                |
      | error     | Method Not Allowed |
      | message   | {P.message}        |
      | path      | {P.path}           |

  Scenario: Delete non existing Project
    When I send a DELETE request to "/project/delete/200"
    And I save response as "P"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {P.timestamp} |
      | status    | 404           |
      | error     | Not Found     |
      | message   | {P.message}   |
      | path      | {P.path}      |