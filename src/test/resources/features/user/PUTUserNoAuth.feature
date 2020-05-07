Feature: User Controller

  Background: Set request
    Given I don't set authentication token

  @negative
  Scenario: Update user credentials of a user without authentication
    When I send a PUT request to "/user/credentials/{normalUser.id}" with the following parameters
      | Password | newpass               |
      | Username | {normalUser.userName} |
    Then I validate the response has status code 403
