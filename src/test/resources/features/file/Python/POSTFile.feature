Feature: File Controller Actions

  Background: Set authentication and create project
    Given I set authentication token using "admin" account
#    And II send a POST request to "/project/new/user/1" with the following parameters
#      | Language     | python                         |
#      | Project Name | PythonPro                      |
#    And I save response as "P"

  Scenario: Create a new Python File
    When I send a POST request to "file/new/project/4" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |
    Then I validate the response has status code 200
    And I validate the response body should match with "file/fileSchema.json" JSON schema
    And I validate the response contains the following data
      | name             | MainClass |
      | project.language | PYTHON_32 |