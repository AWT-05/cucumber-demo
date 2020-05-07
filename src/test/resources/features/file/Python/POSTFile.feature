Feature: File Controller Actions

  Background: Set authentication and create a project

    Given I set authentication token using "admin" account

    * I send a POST request to "/project/new/user/{admin.id}" with the following parameters
      | Language     | python    |
      | Project Name | PythonPro |

    * I save "projectId" value to clean project workspace
    * I save response as "P"

  @deleteFile @deleteProject
  Scenario: Create a Python File

    When I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    Then I validate the response has status code 200
    And I save "fileId" value to clean file workspace
    And I validate the response body should match with "file/fileSchema.json" JSON schema

    And I validate the response contains the following data
      | name             | MainClass |
      | project.language | PYTHON_32 |
