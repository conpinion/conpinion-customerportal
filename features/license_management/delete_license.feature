Feature: Delete a license
  In order to remove obsolete licenses
  as an administrator
  i want to delete the license

  @javascript
  Scenario: Delete a license
    Given I am authenticated as administrator
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And this license for this product to that customer:
      | serial_number | 1234 |
      | machine_code  | abcd |
      | valid_until   | -1   |
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    When I click "Delete" in the row containing "ToDo List"
    And I press "Yes" in the confirmation dialog
    Then I should see "License was successfully deleted"
    And I should not see "ToDo List"
