@deleteUser
Feature: User Controller

  Background: Set authentication
    Given I set authentication token using "admin" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail2@mail.com |
      | First Name | Matt           |
      | Last Name  | Hardy          |
      | Password   | delete         |
      | Username   | broken         |
    And I save response as "resp"
    And I save "userId" value to clean user workspace

  @acceptance
  Scenario: Delete user
    When I send a DELETE request to "/user/delete/{resp.userId}"
    Then I validate the response has status code 200

  @smoke
  Scenario: Delete user without id parameter
    When I send a DELETE request to "/user/delete/"
    Then I validate the response has status code 405

  @negative
  Scenario: Delete user with nonexistent id
    When I send a DELETE request to "/user/delete/9000"
    Then I validate the response has status code 404

  @smoke
  Scenario Outline: Delete user only allows numbers
    When I send a DELETE request to "/user/delete/<id>"
    Then I validate the response has status code 400
    Examples:
      | id |
      | d  |
      | -  |