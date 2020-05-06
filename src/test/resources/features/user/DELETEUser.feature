Feature: User deletion

  Background: Set authentication
    Given I set authentication token using "admin" account

  @acceptanceTest
  Scenario: Delete user
    When I send a DELETE request to "/user/delete/3"
    Then I validate the response has status code 200

  @negativeTest
  Scenario: Delete user nonexistent id
    When I send a DELETE request to "/user/delete/9000"
    Then I validate the response has status code 400

