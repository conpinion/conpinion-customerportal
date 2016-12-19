Feature: List all license pools
  In order to get an overview of license pools granted to our distributors
  as an administrator
  i want to see a list of all license pools

  Scenario: List all license pools
    Given I am authenticated as administrator
    And the following distributor:
      | company | ACME International |
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that distributor is granted a license pool of 1000 for feature "user.count" to that product
    And I am on the home page
    When I click "License pools"
    Then I should see "ACME International"
    And I should see "ToDo List"
    And I should see "User Count"
    And I should see "1000"
