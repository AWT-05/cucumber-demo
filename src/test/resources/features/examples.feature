@Example
Feature: Projects

  Scenario: Create new project
    When I send POST request to "https://jsonplaceholder.typicode.com/posts" endpoint
      """
      {
        "title": "foo",
        "body": "bar",
        "userId": 1
      }
      """
    Then I validate status should be 201
      And I validate response body should match with "src/test/resources/schemas/schemaExample.json" json schema
