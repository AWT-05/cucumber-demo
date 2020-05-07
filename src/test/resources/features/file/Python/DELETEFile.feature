Feature: File Controller Actions

  Background: Set authentication and create project

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

  @deleteProject
  Scenario: Delete a file created

    When I send a DELETE request to "/file/{F.fileId}"
    Then I validate the response has status code 200
#    * the file with "{F.fileId}" isn't more in the database
#    * the file isn't more in the project path in the machine