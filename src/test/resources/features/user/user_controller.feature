#Feature: User controller actions
#
#  Background: Set authentication
#    Given I set authentication token using "admin" account
#
#  Scenario: Get all users
#    When I send a GET request to "/user"
#    Then I validate the response has status code 200
#      And I validate the response body should match with "user/getUsersResponseSchema.json" JSON schema
#
#  Scenario: Get an specific user
#    When I send a GET request to "/user/{id}"
#    Then I validate the response has status code 200
#      And I validate the response body should match with "user/userResponseSchema.json" JSON schema
#      And I validate the response contains the following data
#        | userId    | 2             |
#        | firstName | Diego         |
#        | lastName  | Perez         |
#        | userName  | dperez        |
#        | password  | password      |
#        | email     | mail@mail.com |
#        | rol       | user          |
#
#  Scenario: Update user credentials
#    When I send a PUT request to "/user/credentials/{id}" with the following parameters
#      | Password | newpass |
#      | Username | dperez  |
#    Then I validate the response has status code 200
#      And I validate the response body should match with "user/userResponseSchema.json" JSON schema
#      And I validate the response contains the following data
#        | userId    | 2             |
#        | firstName | Diego         |
#        | lastName  | Perez         |
#        | userName  | dperez        |
#        | password  | newpass       |
#        | email     | mail@mail.com |
#        | rol       | user          |
#
#  Scenario: Delete user
#    When I send a DELETE request to "/user/delete/{id}"
#    Then I validate the response has status code 200
