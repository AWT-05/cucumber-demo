@negative
Feature: Project Controller

  Background: Set authentication
    Given I set authentication token using "normalUser" account

  Scenario: Create Project with incorrect name parameter
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Language    | csharp      |
      | ProjectName | New Project |
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 400                                                     |
      | error   | Bad Request                                             |
      | message | Required String parameter 'Project Name' is not present |
      | path    | /api/v1/project/new/user/2                              |

  Scenario: Create Project without name
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Language | csharp |
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 400                                                     |
      | error   | Bad Request                                             |
      | message | Required String parameter 'Project Name' is not present |
      | path    | /api/v1/project/new/user/2                              |

  Scenario: Create Project with incorrect Language parameter
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Languag      | csharp      |
      | Project Name | New Project |
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 400                                                 |
      | error   | Bad Request                                         |
      | message | Required String parameter 'Language' is not present |
      | path    | /api/v1/project/new/user/2                          |

  Scenario: Create Project with incorrect Language
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Language     | pyton       |
      | Project Name | New Project |
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 400                        |
      | error   | Bad Request                |
      | message | Invalid Language: pyton    |
      | path    | /api/v1/project/new/user/2 |

  Scenario: Create Project without Language
    When I send a POST request to "/project/new/user/2" with the following parameters
      | Project Name | New Project |
    Then I validate the response has status code 400
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 400                                                 |
      | error   | Bad Request                                         |
      | message | Required String parameter 'Language' is not present |
      | path    | /api/v1/project/new/user/2                          |

  Scenario: Create Project without user id
    When I send a POST request to "/project/new/user" with the following parameters
      | Language     | java        |
      | Project Name | New Project |
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 404                      |
      | error   | Not Found                |
      | message | No message available     |
      | path    | /api/v1/project/new/user |

  Scenario: Create Project with non exiting user
    When I send a POST request to "/project/new/user/200" with the following parameters
      | Language     | java        |
      | Project Name | New Project |
    Then I validate the response has status code 404
    And I validate the response body should match with "common/errorSchema.json" JSON schema
    And I validate the response contains the following data
      | status  | 404                          |
      | error   | Not Found                    |
      | message | No value present             |
      | path    | /api/v1/project/new/user/200 |
