Feature: List all customers
  In order to get an overview of all of my customers,
  as a distributor
  i want to see a list of all customers

  Scenario: List all customers
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following customer:
      | name    | Ling Chung     |
      | company | Shenzen Master |
    And I am the responsible distributor of that customer
    And the following customer:
      | name    | Carol Customer                  |
      | company | Customer of another distributor |
    And I am on the home page
    When I click "Customers"
    Then I should see "ACME International"
    And I should see "Shenzen Master"
    And I should not see "Customer of another distributor"

  Scenario: List all customers as an administrator
    Given I am authenticated as administrator
    And the following customer:
      | name    | Ling Chung     |
      | company | Shenzen Master |
    And that customer has the following distributor:
      | company | Bruce Smith        |
      | company | ACME International |
    When I am on the customers page
    Then I should see "ACME International"
    And I should see "Shenzen Master"
