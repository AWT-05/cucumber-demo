Feature: File Controller PUT

  Background: Sets authentication and create project

    Given I set authentication token using "normalUser" account

    * I send a POST request to "/project/new/user/{normalUser.id}" with the following parameters
      | Language     | csharp    |
      | Project Name | CSharpPro |

    * I save "projectId" value to clean project workspace
    * I save response as "P"

    * I send a POST request to "file/new/project/{P.projectId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File Name | MainClass                |

    * I save "fileId" value to clean file workspace
    * I save response as "F"


  @acceptance @deleteFile @deleteProject
  Scenario: Updates a file created

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | Code      | Q29kZSB1cGRhdGVk |
      | File name | name_updated     |

    Then I validate the response has status code 200
    And I validate the response body should match with "file/fileSchema.json" JSON schema

    And I validate the response contains the following data
      | name             | name_updated |
      | project.language | CSHARP       |


  @smoke @deleteFile @deleteProject
  Scenario Outline: cannot update a name if only contains numbers or starts with numbers

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File name | <Name>                   |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Values for the field name
      | Name        |
      | 123         |
      | 8_          |
      | 0valid_name |


  @smoke @deleteFile @deleteProject
  Scenario Outline: The file name cannot be updated if have white spaces

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |
      | File name | <Name>                   |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Values for the field name
      | Name        |
      | valid name  |
      | v_name 1    |
      | mainClass 0 |


# Enhance
  @negative @deleteFile @deleteProject
  Scenario Outline: Updating without some required field

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | <Field> | <Values> |

    Then I validate the response has status code 400

    And I validate the response contains the following data
      | status | 400         |
      | error  | Bad Request |

    Examples: Required fields for a file
      | Field     | Values                   |
      | File name | without_code             |
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== |


# Enhance
  @deleteFile @deleteProject
  Scenario Outline: Allow updating with only one field

    When I send a PUT request to "/file/info/{F.fileId}" with the following parameters
      | <Field> | <Values> |

    Then I validate the response has status code 200

    And I validate the response contains the following data
      | name             | <Response Name> |
      | project.language | CSHARP          |

    Examples: Required fields for a file
      | Field     | Values                   | Response Name |
      | File name | without_code             | without_code  |
      | Code      | cHl0aG9uQ29kZUJhc2U2NA== | MainClass     |
