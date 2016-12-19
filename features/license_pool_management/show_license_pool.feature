Feature: Show a license pool
  In order to see all information about a license pool,
  as a distributor
  i want to display the license pool

  Scenario: Show a license pool
    Given I am authenticated as administrator
    And the following distributor:
      | company | ACME International |
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that distributor is granted a license pool of 1000 for feature "user.count" to that product
    And I am on the license pools page
    When I click "Show" in the row containing "ToDo List"
    Then I should see "ACME International"
    And I should see "ToDo List"
    And  I should see "User Count"
    And I should see "1000"
