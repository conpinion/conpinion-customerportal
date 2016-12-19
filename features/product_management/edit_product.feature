Feature: Edit a product
  In order to change a product's properties
  as an administrator
  i want to edit the product

  Scenario: Edit a products
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.2.3     |
    And I am on the products page
    When I click "Edit" in the row containing "ToDo List"
    And I fill in "Name" with "Modified product"
    And I fill in "Version" with "4.5.6"
    And I press "Update Product"
    Then I should see "Product was successfully updated"
    And I should see "Modified product"
    And I should see the following product in the database:
      | name    | Modified product |
      | version | 4.5.6            |
