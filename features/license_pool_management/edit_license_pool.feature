Feature: Edit a license pool
  In order to modify an existing license pool,
  as an administrator
  i want to edit a license pool

  Scenario: Edit a license pool
    Given I am authenticated as administrator
    And the following distributor with ID "DISTRIBUTOR_ID":
      | company | ACME International |
    And the following product with ID "PRODUCT_ID":
      | name    | ToDo List |
      | version | 1.0.0     |
    And that distributor is granted a license pool of 1000 for feature "user.count" to that product
    And I am on the license pools page
    When I click "Edit" in the row containing "ToDo List"
    And I fill in "Feature name" with "another.count"
    And I fill in "Feature stock" with "123"
    And I press "Update License pool"
    Then I should see "License pool was successfully updated"
    And I should see "Another Count"
    And I should see "123"
    And I should see the following license pool in the database:
      | distributor   | %{DISTRIBUTOR_ID} |
      | product       | %{PRODUCT_ID}     |
      | feature_name  | another.count     |
      | feature_stock | 123               |
