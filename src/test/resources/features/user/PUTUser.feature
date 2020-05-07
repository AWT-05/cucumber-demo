Feature: User Controller

  Background: Set authentication
    Given I set authentication token using "admin" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail2@mail.com |
      | First Name | Matt           |
      | Last Name  | Hardy          |
      | Password   | delete         |
      | Username   | broken         |
    And I save response as "resp"
    And I save "userId" value to clean user workspace

  @acceptanceTest @deleteUser
  Scenario: Update "username" of a user
    When I send a PUT request to "/user/credentials/{resp.userId}" with the following parameters
      | Password | {resp.password} |
      | Username | woken           |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | {resp.userId}  |
      | firstName | Matt           |
      | lastName  | Hardy          |
      | userName  | woken          |
      | password  | delete         |
      | email     | mail2@mail.com |
      | rol       | {resp.rol}     |

  @acceptanceTest @deleteUser
  Scenario: Update "password" of a user
    When I send a PUT request to "/user/credentials/{resp.userId}" with the following parameters
      | Password | newpass         |
      | Username | {resp.userName} |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | {resp.userId}  |
      | firstName | Matt           |
      | lastName  | Hardy          |
      | userName  | broken         |
      | password  | newpass        |
      | email     | mail2@mail.com |
      | rol       | {resp.rol}     |

  @negativeTest @deleteUser
  Scenario: Update credentials of nonexistent user
    When I send a PUT request to "/user/credentials/9000" with the following parameters
      | Password | newpass  |
      | Username | userName |
    Then I validate the response has status code 500

  @negativeTest @deleteUser
  Scenario: Update credentials without new "Password"
    When I send a PUT request to "/user/credentials/{resp.userId}" with the following parameters
      | Username | userName |
    Then I validate the response has status code 400

  @negativeTest @deleteUser
  Scenario: Update credentials without new "Username"
    When I send a PUT request to "/user/credentials/{resp.userId}" with the following parameters
      | Password | newpass |
    Then I validate the response has status code 400