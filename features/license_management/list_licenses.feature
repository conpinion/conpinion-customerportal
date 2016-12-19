Feature: List all licenses of a customer
  In order to get an overview of licenses of my customers
  as a distributor
  i want to see a list of all licenses

  Scenario: List all licenses
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And this license for this product to that customer:
      | serial_number | 1234 |
    And the following product:
      | name    | License Manager |
      | version | 2.0.1           |
    And this license for this product to that customer:
      | serial_number | 4567 |
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    Then I should see "ToDo List"
    And I should see "1.0.0"
    And I should see "1234"
    Then I should see "License Manager"
    And I should see "2.0.1"
    And I should see "4567"
