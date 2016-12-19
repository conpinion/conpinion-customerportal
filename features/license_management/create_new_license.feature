Feature: Create a new license
  In order to license a product to one of my customers
  as a distributor
  i want to add a new license to the customer's license list

  @javascript
  Scenario: Create a new license
    Given I am authenticated as distributor
    And the following customer with ID "CUSTOMER_ID":
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product with ID "PRODUCT_ID":
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product is assigned to my distributor
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I press "New License"
    And I select "ToDo List 1.0.0" from "Product"
    And I fill in "Valid until" with "03112020"
    And I fill in "Machine code" with "abcd"
    And I press "Create License"
    Then I should see "License was successfully created"
    And I should see "ToDo List"
    And I should see "abcd"
    And I should see the following license in the database:
      | customer_id  | %{CUSTOMER_ID} |
      | product_id   | %{PRODUCT_ID}  |
      | machine_code | abcd           |
      | valid_until  | 2020-11-03     |
