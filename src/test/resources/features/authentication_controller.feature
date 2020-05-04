Feature: Authenticate actions

  Scenario: Get authentication token
    Given Paolo is an user of Moi
    When he sends a POST request to "/authenticate" endpoint with the following credentials
      """
      {
        "password": "stayhome",
        "username": "admin"
      }
      """
    Then he receives a response status code 200 and a "token"