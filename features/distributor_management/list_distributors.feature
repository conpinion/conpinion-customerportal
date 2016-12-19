Feature: List all distributors
  In order to get an overview of all distributors,
  as an administrator
  i want to see a list of all distributors

  Scenario: List all distributors
    Given the following distributor:
      | company | ACME International |
    Given the following distributor:
      | company | Shenzen Master |
    And I am authenticated as administrator
    And I am on the home page
    When I click "Distributors"
    Then I should see "ACME International"
    And I should see "Shenzen Master"
