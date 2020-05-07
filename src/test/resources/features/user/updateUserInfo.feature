
Feature: User Info Update

  Background: Set authentication and create a user
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio      |
      | Last Name  | Oroza         |
      | Password   | 1234          |
      | Username   | mau           |

    And I save response as "Uresponse"
    And I save the id as "Uid"
    Then I validate the response has status code 200

  @acceptance
  Scenario: Update existing User
    When I send a PUT request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Name | MauricioUpdated |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | MauricioUpdated |
      | lastName  | Oroza           |
      | userName  | mau             |
      | password  | 1234            |
      | email     | mail@mail.com   |
      | rol       | {Uresponse.rol} |

  @smoke
  Scenario: Update existing User
    When I send a PUT request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Name | MauricioUpdated  |
      | E-mail     | Updated@mail.com |
      | lastName   | OrozaUpdated     |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | MauricioUpdated  |
      | lastName  | OrozaUpdated     |
      | userName  | mau              |
      | password  | 1234             |
      | email     | Updated@mail.com |
      | rol       | {Uresponse.rol}  |

  @NegativeTest
  Scenario: Create a new Project with incorrect name parameter
    When I send a POST request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Name       | MauricioUpdated  |
      | E-mail           | Updated@mail.com |
      | dfs$$sdfsdafName | OrozaUpdated     |
    And I save response as "Uresponse"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {Uresponse.timestamp} |
      | status    | 400                   |
      | error     | Bad Request           |
      | message   | {Uresponse.message}   |
      | path      | {Uresponse.path}      |
