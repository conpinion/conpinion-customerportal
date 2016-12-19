Feature: Show a license
  In order to see all information about a license,
  as a distributor
  i want to display the license

  Scenario: Show a license
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
      | machine_code  | abcd |
      | valid_until   | -1   |
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I click "Show" in the row containing "ToDo List"
    Then I should see "ToDo List"
    And I should see "1.0.0"
    And I should see "abcd"
    And I should see "∞"
