@negative
Feature: File Controller GET

  @acceptance
  Scenario: Gets a Python File without authentication

    When I send a GET request to "/file/1"
    Then I validate the response has status code 403

    And I validate the response contains the following data
      | status | 403       |
      | error  | Forbidden |


# Enhance
  Scenario Outline: Gets a file with an ID that doesn't exist

    Given I set authentication token using "normalUser" account
    When I send a GET request to "/file/<Bad ID>"
    Then I validate the response has status code 404

    And I validate the response contains the following data
      | status | 404       |
      | error  | Not Found |

    Examples: Nonexistent ID
      | Bad ID |
      | 0      |


  Scenario Outline: Only numbers are allowed for ID values

    Given I set authentication token using "normalUser" account
    When I send a GET request to "/file/<Bad ID>"
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