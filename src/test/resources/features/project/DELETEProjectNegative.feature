@negative
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Delete Project without project id
    When I send a DELETE request to "/project/delete"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 405                                   |
      | error   | Method Not Allowed                    |
      | message | Request method 'DELETE' not supported |
      | path    | /api/v1/project/delete                |

  Scenario: Delete non existing Project
    When I send a DELETE request to "/project/delete/400"
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 404                        |
      | error   | Not Found                  |
      | message | No value present           |
      | path    | /api/v1/project/delete/400 |