Feature: File Controller DELETE

  Background: Sets authentication and create project

    Given I set authentication token using "normalUser" account

    * I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language     | csharp    |
      | Project Name | CSharpPro |

    * I save "projectId" value to clean project workspace
    * I save response as "P"

    * I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    * I save "fileId" value to clean file workspace
    * I save response as "F"


  @acceptance @deleteProject
  Scenario: Deletes a file created

    When I send a DELETE request to "/file/{F.fileId}"
    Then I validate the response has status code 200
    * I send a GET request to "/file/{F.fileId}"
    * I validate the response has status code 404
