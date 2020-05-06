Feature: File Controller Actions

  Background: Set authentication and create project
    Given I set authentication token using "admin" account
    And as "admin" I have a project created of "python" type and save response as "res"
    And I have a "file" created in response saved

  @deleteFile @deleteProject
  Scenario: Get a file created
    When I send a GET request to "/file/{file.fileId}"
    Then I validate the response has status code 200
      And I validate the response body should match with "file/fileSchema.json" JSON schema
      And I validate the response contains the following data
        | name             | MainClass |
        | project.language | PYTHON_32 |
