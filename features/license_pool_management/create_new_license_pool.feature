Feature: Create a new license pool
  In order to provide a distributor a pool of licenses,
  as an administrator
  i want to create a new license pool

  Scenario: Create a new license pool
    Given I am authenticated as administrator
    And the following distributor with ID "DISTRIBUTOR_ID":
      | company | ACME International |
    And the following product with ID "PRODUCT_ID":
      | name    | ToDo List |
      | version | 1.0.0     |
    And I am on the license pools page
    When I press "New License pool"
    And I select "ACME International" from "Distributor"
    And I select "ToDo List 1.0.0" from "Product"
    And I fill in "Feature name" with "user.count"
    And I fill in "Feature stock" with "1000"
    And I press "Create License pool"
    Then I should see "License pool was successfully created"
    And I should see "User Count"
    And I should see "1000"
    And I should see the following license pool in the database:
      | distributor   | %{DISTRIBUTOR_ID} |
      | product       | %{PRODUCT_ID}     |
      | feature_name  | user.count        |
      | feature_stock | 1000              |
