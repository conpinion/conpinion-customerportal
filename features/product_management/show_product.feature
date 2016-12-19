Feature: Show a product
  In order to see all information about one of my products,
  as an administrator
  i want to display the product

  Scenario: Show a product
    Given I am authenticated as administrator
    And the following product:
      | name | ToDo List |
    And I am on the products page
    When I click "Show" in the row containing "ToDo List"
    And I should see "ToDo List"
