Feature: List all products
  In order to get an overview of all of my products,
  as an administrator
  i want to see a list of all product

  Scenario: List all products
    Given I am authenticated as administrator
    And the following product:
      | name | ToDo List |
    And the following product:
      | name | License Manager |
    And I am on the home page
    When I click "Products"
    Then I should see "ToDo List"
    And I should see "License Manager"
