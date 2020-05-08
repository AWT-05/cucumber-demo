@deleteUser
Feature: User Controller

  Background: Set authentication and create a user
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio      |
      | Last Name  | Oroza         |
      | Password   | 1234          |
      | Username   | mau           |
    And I save response as "Uresponse"
    And I save "userId" value to clean project workspace
    Then I validate the response has status code 200

  @acceptance
  Scenario: Update existing user rol from User to Admin
    When I send a PUT request to "/user/rol/{Uresponse.userId}" with the following parameters
      | Rol | admin |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserRolSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Mauricio      |
      | lastName  | Oroza         |
      | userName  | mau           |
      | password  | 1234          |
      | email     | mail@mail.com |
      | rol       | admin         |

  @negative
  Scenario: Send a bad input parameter Rol to validate Bad Request
    When I send a PUT request to "/user/rol/{Uresponse.userId}" with the following parameters
      | Rol123ewe$ | admin |
    And I save response as "Uresponse"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

  @negative
  Scenario: Update existing user rol from User incorrect rol parameter
    When I send a PUT request to "/user/rol/{Uresponse.userId}" with the following parameters
      | Rol | adm$12"%$$in |
    And I save response as "Uresponse"
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserRolSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Mauricio |
      | lastName  | Oroza    |
      | rol       | user     |

  @negative
  Scenario: Update existing user rol with incorrect HTTP method
    When I send a POST request to "/user/rol/{Uresponse.userId}" with the following parameters
      | Rol123 | admin |
    And I save response as "Uresponse"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status | 405                |
      | error  | Method Not Allowed |

  @negative
  Scenario: Update existing user rol without User Id
    When I send a PUT request to "/user/rol" with the following parameters
      | Rol | admin |
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 405                                |
      | error   | Method Not Allowed                 |
      | message | Request method 'PUT' not supported |

  @negative
  Scenario: Update existing User without am existing User Id
    When I send a PUT request to "/user/rol/9999" with the following parameters
      | Rol | admin |
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status | 404       |
      | error  | Not Found |
