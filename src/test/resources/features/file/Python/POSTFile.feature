Feature: File Controller Actions

  Background: Set authentication and create project
    Given I set authentication token using "admin" account
      And as "admin" I have a project created of "python" type and save response as "res"

  @deleteFile
  Scenario: Create a new Python File
    When I send a POST request to "file/new/project/{res.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |
#      And I save response as "P"
      And I save the "fileId" value
    Then I validate the response has status code 200
      And I validate the response body should match with "file/fileSchema.json" JSON schema
      And I validate the response contains the following data
        | name             | MainClass |
        | project.language | PYTHON_32 |
