#@deleteUser
Feature: User Controller

  Background: Set authentication and create a user
    Given I set authentication token using "normalUser" account
    When I send a POST request to "/user/new" with the following parameters
      | E-mail     | mail@mail.com |
      | First Name | Ramiro        |
      | Last Name  | Herbas        |
      | Password   | pass          |
      | Username   | xyz           |
    And I save response as "Uresponse"
    And I save "userId" value to clean project workspace
    Then I validate the response has status code 200

  @acceptance @deleteUser
  Scenario: Update existing User with basic parameters
    When I send a PUT request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Name | MauricioUpdated |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | MauricioUpdated |

  @smoke @deleteUser
  Scenario: Update existing User with all the parameters
    When I send a PUT request to "/user/info/{Uresponse.userId}" with the following parameters
      | E-mail     | Updated@mail.com |
      | First Name | MauricioUpdated  |
      | Last Name  | OrozaUpdated     |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/updateUserSchema.json" JSON schema
    And I validate the response contains the following data
      | firstName | MauricioUpdated  |
      | lastName  | OrozaUpdated     |
      | userName  | mau              |
      | password  | 1234             |
      | email     | Updated@mail.com |
      | rol       | {Uresponse.rol}  |

  @negative @deleteUser
  Scenario: Update existing User with incorrect lastName parameter
    When I send a PUT request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Namesdfgdshfr | MauricioUpdated  |
      | E-mail              | Updated@mail.com |
    And I save response as "Uresponse"
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

  @negative @deleteUser
  Scenario: Update existing User with incorrect HTTP method
    When I send a POST request to "/user/info/{Uresponse.userId}" with the following parameters
      | First Namesdfgdshfr | MauricioUpdated  |
      | E-mail              | Updated@mail.com |
    And I save response as "Uresponse"
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status | 405                |
      | error  | Method Not Allowed |

  @negative @deleteUser
  Scenario: Update existing User without User id
    When I send a PUT request to "/user/info" with the following parameters
      | First Name | MauricioUpdated |
    Then I validate the response has status code 405
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 405                                |
      | error   | Method Not Allowed                 |
      | message | Request method 'PUT' not supported |

  @negative @deleteUser
  Scenario: Update existing User without am existing User Id
    When I send a PUT request to "/user/info/150" with the following parameters
      | First Name | MauricioUpdated |
    Then I validate the response has status code 500
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 500                   |
      | error   | Internal Server Error |
      | message | No value present      |
