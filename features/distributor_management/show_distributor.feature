Feature: Show a distributor
  In order to see all information about an existing distributor,
  as an administrator
  i want to display a distributor

  Scenario: Show a distributor
    Given the following distributor:
      | company | ACME International |
    And that distributor embeds the following address:
      | street   | 2640 Rose Avenue |
      | zip_code | PA 19090         |
      | city     | Willow Grove     |
      | country  | US               |
    And that distributor has the following distributor_user as responsible:
      | family_name | Alice Agarwal |
    And I am authenticated as administrator
    And I am on the distributors page
    When I click "Show" in the row containing "ACME International"
    And I should see "ACME International"
    And I should see "2640 Rose Avenue, PA 19090, Willow Grove, United States"
    And I should see "Alice Agarwal"
