Feature: Create a new user un MOI

  Background: Set authentication
    Given I set authentication token using admin account

  @AcceptanceTest
  Scenario: Create a new user
    When I send a POST request to "/user/new" with the following parameters
      | First Name | Esteban |
      | Password   | pass    |
      | Username   | est     |
    Then I validate the response has status code 200
    And Response body should match with "user/createUserResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Esteban |
      | userName  | est     |
      | password  | pass    |
      | rol       | user    |

  @SmokeTest
  Scenario: Create a new user
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio      |
      | Last Name  | Oroza         |
      | Password   | 1234          |
      | Username   | mau           |
    Then I validate the response has status code 200
    And Response body should match with "user/createUserResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | Mauricio      |
      | lastName  | Oroza         |
      | userName  | mau           |
      | password  | 1234          |
      | email     | mail@mail.com |
      | rol       | user          |

  @NegativeTest
  Scenario: Create a new Project with incorrect name parameter
    When I send a POST request to "/user/new" with the following parameters
      | First Namee | Esteban |
      | Password    | pass    |
      | Username    | est     |
    And I save response as "Uresponse"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | timestamp | {Uresponse.timestamp} |
      | status    | 400                   |
      | error     | Bad Request           |
      | message   | {Uresponse.message}   |
      | path      | {Uresponse.path}      |
