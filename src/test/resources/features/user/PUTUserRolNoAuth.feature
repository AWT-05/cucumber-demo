Feature: User Controller

  @negative
  Scenario: Update existing User rol with no authentication
    When I send a PUT request to "/user/rol/2" with the following parameters
      | Rol | admin |
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403           |
      | error   | Forbidden     |
      | message | Access Denied |
