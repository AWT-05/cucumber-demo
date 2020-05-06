Feature: User updates

  Background: Set authentication
    Given I set authentication token using "admin" account

  @acceptanceTest
  Scenario: Update user credentials
    When I send a PUT request to "/user/credentials/2" with the following parameters
      | Password | newpass |
      | Username | dperez  |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | 2             |
      | firstName | Diego         |
      | lastName  | Perez         |
      | userName  | dperez        |
      | password  | newpass       |
      | email     | mail@mail.com |
      | rol       | user          |

  @negativeTest
  Scenario: Update user credentials
    When I send a PUT request to "/user/credentials/9000" with the following parameters
      | Password | newpass |
      | Username | dperez  |
    Then I validate the response has status code 400