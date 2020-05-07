Feature: User deletion

  Background: Set request
    Given I don't set authentication token

  @negativeTest
  Scenario: Delete user without authentication
    When I send a DELETE request to "/user/delete/{normalUser.id}"
    Then I validate the response has status code 403

  @negativeTest
  Scenario: Get all users without authentication
    When I send a GET request to "/user"
    Then I validate the response has status code 403

  @negativeTest
  Scenario: Get an specific user without authentication
    When I send a GET request to "/user/{normalUser.id}"
    Then I validate the response has status code 403

  @negativeTest
  Scenario: Update user credentials of a user without authentication
    When I send a PUT request to "/user/credentials/{normalUser.id}" with the following parameters
      | Password | newpass               |
      | Username | {normalUser.userName} |
    Then I validate the response has status code 403