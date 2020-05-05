@NormalTest
Feature: User Info Update

  Background: Set authentication and create a project
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/user/new/" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Mauricio      |
      | Last Name  | Oroza         |
      | Password   | 1234          |
      | Username   | mau           |

    And I save response as "Uresponse"
    Then I validate the response has status code 200

  Scenario: Update existing User
    When I send a PUT request to "/user/info/{Uresponse.id}" with the following parameters
      | E-mail     | updated@mail.com |
      | First Name | MauricioUpdated  |
      | LastName   | OrozaUpdated     |
    Then I validate the response has status code 200
    And Response body should match with "user/updateUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | MauricioUpdated  |
      | lastName  | OrozaUpdated     |
      | userName  | mau              |
      | password  | 1234             |
      | email     | updated@mail.com |
      | rol       | user             |
