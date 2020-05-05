Feature: User deletion

  Background: Set authentication
    Given I set authentication with an admin account

  Scenario: Delete user
    When I send a DELETE request to "/user/delete/{id}"
    Then I validate response code should be 200

  Scenario: Delete user nonexistent id
    When I send a DELETE request to "/user/delete/{id}"
      And I send a nonexistent id as parameter
    Then I validate response code should be 400

  Scenario: Delete user without authentication
    When I send a DELETE request to "/user/delete/{id}"
      And I no longer have authentication valid
    Then I validate response code should be 403