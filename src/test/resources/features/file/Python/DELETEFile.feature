Feature: File Controller Actions By DELETE

  Background: Sets authentication and create project

    Given I set authentication token using "normalUser" account

    * I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
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
  Scenario: Deletes a file created

    When I send a DELETE request to "/file/{F.fileId}"
    Then I validate the response has status code 200
    * I send a GET request to "/file/{F.fileId}"
    * I validate the response has status code 404


# Enhance
  @deleteFile @deleteProject
  Scenario Outline: Deletes a file with an ID that doesn't exist

    When I send a DELETE request to "/file/<Bad ID>"
    Then I validate the response has status code 404

    And I validate the response contains the following data
      | status | 404       |
      | error  | Not Found |

    Examples:  Nonexistent ID
      | Bad ID |
      | 0      |


  @deleteFile @deleteProject
  Scenario Outline: Only numbers are allowed for ID values

    When I send a DELETE request to "/file/<Bad ID>"
    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: ID not allowed
      | Bad ID  |
      | abc     |
      | #000    |
      | @123    |
      | 45!6    |
      | 32$1    |
      | 45?6    |
      | 321*    |
      | 321/    |
      | 321.34  |
      | 456'321 |
      | 456^321 |
      | [321]   |
      | <321>   |