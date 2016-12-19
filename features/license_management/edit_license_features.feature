Feature: Edit the license features
  Because I want a great user experience when editing the license features
  as a distributor
  I want a single input field per license feature

  @javascript
  Scenario: Edit the license features
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product is assigned to my distributor
    And that product has a number feature with name "user_count"
    And that product has a boolean feature with name "premium_mode"
    And this license for this product to that customer:
      | serial_number | 1234 |
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I click "Edit" in the row containing "ToDo List"
    And I fill in "User Count" with "123"
    And I toggle "Premium Mode"
    And I press "Update License"
    Then I should see "License was successfully updated"
    And I should see the following license in the database:
      | serial_number | 1234 |
    And that license should have the following features:
      | user_count   | 123  |
      | premium_mode | true |

  @javascript
  Scenario: Features appear when a product is selected for a new license
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product is assigned to my distributor
    And that product has a number feature with name "user_count"
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I press "New License"
    Then I should not see "User Count"
    When I select "ToDo List 1.0.0" from "Product"
    Then I should see "User Count"
