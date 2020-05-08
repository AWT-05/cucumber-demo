Feature: User Controller

  Background: Set request
    Given I don't set authentication token

  @negative
  Scenario: Get all users without authentication
    When I send a GET request to "/user"
    Then I validate the response has status code 403

  @negative
  Scenario: Get an specific user without authentication
    When I send a GET request to "/user/{normalUser.id}"
    Then I validate the response has status code 403
    