Feature: Create a new product
  In order to sell new product licenses
  as an administrator
  i want to add a new product to my product list

  Scenario: Create a new product
    Given I am authenticated as administrator
    And I am on the products page
    When I press "New Product"
    And I fill in "Name" with "ToDo List"
    And I fill in "Version" with "3.1.0"
    And I press "Create Product"
    Then I should see "Product was successfully created"
    And I should see "ToDo List"
    And I should see the following product in the database:
      | name    | ToDo List |
      | version | 3.1.0     |
