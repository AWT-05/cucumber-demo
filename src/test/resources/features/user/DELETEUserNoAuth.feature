Feature: User Controller

  Background: Set request
    Given I don't set authentication token

  @negative
  Scenario: Delete user without authentication
    When I send a DELETE request to "/user/delete/{normalUser.id}"
    Then I validate the response has status code 403
