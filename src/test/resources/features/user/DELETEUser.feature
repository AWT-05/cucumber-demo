Feature: User deletion

  Background: Set authentication
    Given I set authentication token using "admin" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail2@mail.com |
      | First Name | Matt           |
      | Last Name  | Hardy          |
      | Password   | broken         |
      | Username   | delete         |
    And I save response as "resp"

  @acceptanceTest
  Scenario: Delete user
    When I send a DELETE request to "/user/delete/{resp.userId}"
    Then I validate the response has status code 200

  @negativeTest
  Scenario: Delete user nonexistent id
    When I send a DELETE request to "/user/delete/9000"
    Then I validate the response has status code 500

