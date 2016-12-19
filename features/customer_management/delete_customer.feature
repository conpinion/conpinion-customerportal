Feature: Delete a customer
  In order to remove obsolete customers
  as an administrator
  i want to delete the customer

  @javascript
  Scenario: Delete a customer
    Given I am authenticated as administrator
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am on the customers page
    When I click "Delete" in the row containing "ACME International"
    And I press "Yes" in the confirmation dialog
    Then I should see "Customer was successfully deleted"
    And I should not see "ACME International"
