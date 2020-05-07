Feature: User Controller

  @negative
  Scenario: Update existing User with no authentication
    When I send a PUT request to "/user/info/2" with the following parameters
      | E-mail     | Updated@mail.com |
      | First Name | MauricioUpdated  |
      | Last Name  | OrozaUpdated     |
    Then I validate the response has status code 403
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 403           |
      | error   | Forbidden     |
      | message | Access Denied |
