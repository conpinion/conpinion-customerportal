Feature: Delete a license pool
  In order remove license pool from the system,
  as an administrator
  i want to delete a license pool

  @javascript
  Scenario: Delete a license pool
    Given I am authenticated as administrator
    And the following distributor with ID "DISTRIBUTOR_ID":
      | company | ACME International |
    And the following product with ID "PRODUCT_ID":
      | name    | ToDo List |
      | version | 1.0.0     |
    And that distributor is granted a license pool of 1000 for feature "user.count" to that product
    And I am on the license pools page
    When I click "Delete" in the row containing "ACME International"
    And I press "Yes" in the confirmation dialog
    Then I should see "License pool was successfully deleted"
    And I should not see "ACME International"
