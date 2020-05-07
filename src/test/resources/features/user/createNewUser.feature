Feature: Create a user

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  @acceptance #@deleteUser
  Scenario: Run acceptance test with basic requirements
    When I send a POST request to "/user/new" with the following parameters
      | First Name | Esteban |
      | Password   | pass    |
      | Username   | est     |
    And I save response as "Uresponse"
    Then I validate the response has status code 200
    And I validate the response body should match with "user/createNewUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Esteban              |
      #| lastName  | {Uresponse.lastName} |
      #| email     | {Uresponse.email}    |
      | userName  | est                  |
      | password  | pass                 |
      | rol       | user                 |
      #| userId    | {Uresponse.userId}   |

  @smoke
  Scenario: Run a smoke test with all the parameters
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio      |
      | Last Name  | Oroza         |
      | Password   | 1234          |
      | Username   | mau           |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/createNewUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Mauricio      |
      | lastName  | Oroza         |
      | userName  | mau           |
      | password  | 1234          |
      | email     | mail@mail.com |
      | rol       | user          |

  @negative
  Scenario: Create a new user with incorrect name parameter
    When I send a POST request to "/user/new" with the following parameters
      | First Namee | Esteban |
      | Password    | pass    |
      | Username    | est     |
    And I save response as "Uresponse"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status    | 400                   |
      | error     | Bad Request           |
