@negative
Feature: File Controller

  @acceptance @deleteFile
  Scenario: Creates a CSharp File without authentication

    When I send a POST request to "file/new/project/1" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    Then I validate the response has status code 403

    And I validate the response contains the following data
      | status | 403       |
      | error  | Forbidden |


# Enhance
  @deleteFile
  Scenario Outline: Cannot create a file with an project ID that doesn't exist

    Given I set authentication token using "normalUser" account

    When I send a POST request to "file/new/project/<Bad ID>" with the following parameters
      | Code      | Q29kZSB1cGRhdGVk |
      | File Name | name_updated     |

    Then I validate the response has status code 404

    And I validate the response contains the following data
      | status | 404       |
      | error  | Not Found |

    Examples: Nonexistent ID
      | Bad ID |
      | 0      |
