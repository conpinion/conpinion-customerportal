Feature: Delete a distributor
  In order remove distributor from the system,
  as an administrator
  i want to delete a distributor

  @javascript
  Scenario: Delete a distributor
    Given the following distributor:
      | company | ACME International |
    And I am authenticated as administrator
    And I am on the distributors page
    When I click "Delete" in the row containing "ACME International"
    And I press "Yes" in the confirmation dialog
    Then I should see "Distributor was successfully deleted"
    And I should not see "ACME International"
