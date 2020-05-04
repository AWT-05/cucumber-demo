Feature: File Controller Actions

  Background: Set authentication
    # Given I set authentication token using "admin"
    Given Paolo is authenticate in Moi app

  Scenario: Create a new Python File
    Given Paolo has a project created of type "Python"
    When he sends a POST request to "file/new/project/{project.id}" with the following query params
      | Code      | {pythonCodeBase64} |
      | File Name | MainClass          |
    Then he receives a response with status code 200
    And the response body should match with "file/fileSchema.json" JSON schema
    And the response contains the following data
      | name             | MainClass |
      | project.language | PYTHON_32 |


  Scenario: Create a new Java File
    Given Paolo has a project created of type "Java"
    When he sends a POST request to "file/new/project/{project.id}" with the following query params
      | Code      | {javaCodeBase64} |
      | File Name | MainClass        |
    Then he receives a response with status code 200
    And the response body should match with "file/fileSchema.json" JSON schema
    And the response contains the following data
      | name             | MainClass |
      | project.language | JAVA      |

  Scenario: Create a new CSharp File
    Given Paolo has a project created of type "CSharp"
    When he sends a POST request to "file/new/project/{project.id}" with the following query params
      | Code      | {csharpCodeBase64} |
      | File Name | MainClass          |
    Then he receives a response with status code 200
    And the response body should match with "file/fileSchema.json" JSON schema
    And the response contains the following data
      | name             | MainClass |
      | project.language | CSHARP    |


  Scenario Outline: Get a file created
    Given Paolo has a file created of type "<Language>"
    When he sends a GET request to "/file/<ID>" to see the file
    Then he receives a response with status code 200
    And the response body should match with "file/fileSchema.json" JSON schema
    * contains the name field "<ClassName>"
    * the project language should be of type "<Language>"

    Examples:
      | Language  | ClassName | ID        |
      | PYTHON_32 | MainClass | {file.id} |
      | JAVA      | MainClass | {file.id} |
      | CSHARP    | MainClass | {file.id} |


  Scenario Outline: Update file information
    Given Paolo has a file created of type "<Language>"
    When he sends a PUT request to "/file/info/<ID>" with the following query params
      | Code      | <Value>     |
      | File Name | <ClassName> |
    Then he receives a response with status code 200
    And Response body should match with "file/fileSchema.json" JSON schema
    * contains the name field "<ClassName>"
    * the project language should be of type "<Language>"

    Examples:
      | Language  | ID        | ClassName | Value         |
      | PYTHON_32 | {file.id} | MainClass | {python.code} |
      | JAVA      | {file.id} | MainClass | {java.code}   |
      | CSHARP    | {file.id} | MainClass | {csharp.code} |

  Scenario: Delete a file created
    Given Paolo has a file created
    When he sends a DELETE request to "/file/{file.id}"
    Then he receives a response with status code 200
    * the file isn't more in the database
    * the file isn't more in the project path in the machine