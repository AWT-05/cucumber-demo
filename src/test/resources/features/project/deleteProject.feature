@acceptance
Feature: Project Controller

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Description  | New Project Description |
      | Language     | python                  |
      | Project Name | New Project             |
    And I save response as "P"
    Then I validate the response has status code 200

  Scenario: Delete existing Project
    When I send a DELETE request to "/project/delete/{P.projectId}"
    Then I validate the response has status code 200
    And I validate the response does not contain data