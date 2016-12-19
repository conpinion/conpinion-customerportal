Feature: Delete a product
  Because I no longer want to sell licenses for a product
  as an administrator
  i want to delete the product

  @javascript
  Scenario: Delete a product
    Given I am authenticated as administrator
    And the following product:
      | name | ToDo List |
    And I am on the products page
    When I click "Delete" in the row containing "ToDo List"
    And I press "Yes" in the confirmation dialog
    Then I should see "Product was successfully deleted"
    And I should not see "ToDo List"
