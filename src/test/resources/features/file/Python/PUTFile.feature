Feature: File Controller Actions

  Background: Sets authentication and create project

    Given I set authentication token using "admin" account

    * I send a POST request to "/project/new/user/{admin.id}" with the following parameters
      | Language     | python    |
      | Project Name | PythonPro |

    * I save "projectId" value to clean project workspace
    * I save response as "P"

    * I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    * I save "fileId" value to clean file workspace
    * I save response as "F"

  @deleteFile @deleteProject
  Scenario: Updates a file created

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | Code      | Q29kZSB1cGRhdGVk |
      | File name | Name updated     |

    Then I validate the response has status code 200
    And I validate the response body should match with "file/fileSchema.json" JSON schema

    And I validate the response contains the following data
      | name             | Name updated |
      | project.language | PYTHON_32    |
