Feature: Create a new distributor
  In order to provide a new distributor access to the system,
  as an administrator
  i want to create a new distributor

  Scenario: Create a new distributor
    Given the following distributor_user with ID "USER_ID":
      | email       | alice@example.com |
      | family_name | Alice Agarwal     |
    And I am authenticated as administrator
    And I am on the distributors page
    When I press "New Distributor"
    And I fill in "Company" with "Shenzen Master"
    And I fill in "Street" with "63 Renmin Lu"
    And I fill in "ZIP Code" with "266033"
    And I fill in "City" with "Shandong"
    And I select "China" from "Country"
    And I select "Alice Agarwal" from "Responsible"
    And I press "Create Distributor"
    Then I should see "Distributor was successfully created"
    And I should see "Shenzen Master"
    And I should see the following distributor in the database:
      | company     | Shenzen Master |
      | responsible | %{USER_ID}     |
