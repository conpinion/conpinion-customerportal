Feature: Edit a license
  In order to modify one of my customer's licenses,
  as a distributor
  i want to edit the license

  @javascript
  Scenario: Edit a license
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product is assigned to my distributor
    And this license for this product to that customer:
      | serial_number | 1234 |
      | machine_code  | abcd |
      | valid_until   | -1   |
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I click "Edit" in the row containing "ToDo List"
    And I fill in "Valid until" with "03112020"
    And I press "Update License"
    Then I should see "License was successfully updated"
    And I should see "2020-11-03"
    And I should see the following license in the database:
      | serial_number | 1234       |
      | valid_until   | 2020-11-03 |
