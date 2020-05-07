Feature: User updates

  Background: Set authentication
    Given I set authentication token using "admin" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail2@mail.com |
      | First Name | Matt           |
      | Last Name  | Hardy          |
      | Password   | broken         |
      | Username   | delete         |
    And I save response as "resp"

  @acceptanceTest
  Scenario: Update user credentials of a user
    When I send a PUT request to "/user/credentials/{resp.userId}" with the following parameters
      | Password | newpass         |
      | Username | {resp.userName} |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | {resp.userId}  |
      | firstName | Matt           |
      | lastName  | Hardy          |
      | userName  | delete         |
      | password  | newpass        |
      | email     | mail2@mail.com |
      | rol       | {resp.rol}     |

  @negativeTest
  Scenario: Update user credentials of nonexistent user
    When I send a PUT request to "/user/credentials/9000" with the following parameters
      | Password | newpass  |
      | Username | userName |
    Then I validate the response has status code 500