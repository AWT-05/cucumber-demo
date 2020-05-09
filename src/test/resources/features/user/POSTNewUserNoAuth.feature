Feature: User Controller

  @negative
  Scenario: Create a user with no authentication
    When I send a POST request to "/user/new" with the following parameters
      | First Name | Esteban |
      | Password   | pass    |
      | Username   | est     |
    And I save response as "Uresponse"
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403           |
      | error   | Forbidden     |
      | message | Access Denied |

  @negative
  Scenario: Create a new user without required parameters
    When I send a POST request to "/user/new" with the following parameters
      | Username | mau |
    And I save response as "Uresponse"
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403           |
      | error   | Forbidden     |
      | message | Access Denied |