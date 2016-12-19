Feature: Show a customer
  In order to see all information about one of my customers,
  as a distributor
  i want to display the customer

  Scenario: Show a customer
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And that customer embeds the following address:
      | street   | 2640 Rose Avenue |
      | zip_code | PA 19090         |
      | city     | Willow Grove     |
      | country  | US               |
    And I am on the customers page
    When I click "Show" in the row containing "ACME International"
    And I should see "ACME International"
    And I should see "2640 Rose Avenue, PA 19090, Willow Grove, United States"
