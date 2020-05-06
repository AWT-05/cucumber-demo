Feature: File Controller Actions

  Background: Set authentication and create project
    Given I set authentication token using "admin" account
#    And II send a POST request to "/project/new/user/1" with the following parameters
#      | Language     | csharp                         |
#      | Project Name | CSharpPro                      |
#    And I save response as "P"
#    Given Paolo has a file created of type "<Language>"

  Scenario: Delete a file created
    When I send a DELETE request to "/file/{file.id}"
    Then I validate the response has status code 200
    * the file isn't more in the database
    * the file isn't more in the project path in the machine