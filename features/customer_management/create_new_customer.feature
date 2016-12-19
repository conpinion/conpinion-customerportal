Feature: Create a new customer
  In order to serve a new customer
  as a distributor
  i want to add a new customer to my customer list

  Scenario: Create a new customer
    Given I am authenticated as distributor
    And the following distributor with ID "DISTRIBUTOR_ID":
      | company | ACME International |
    And I am the responsible of that distributor
    And I am on the customers page
    When I press "New Customer"
    And I fill in "Name" with "Ling Chung"
    And I fill in "Company" with "Shenzen Master"
    And I fill in "Street" with "63 Renmin Lu"
    And I fill in "ZIP Code" with "266033"
    And I fill in "City" with "Shandong"
    And I select "China" from "Country"
    And I press "Create Customer"
    Then I should see "Customer was successfully created"
    And I should see "Shenzen Master"
    And I should see the following customer in the database:
      | name           | Ling Chung        |
      | company        | Shenzen Master    |
      | distributor_id | %{DISTRIBUTOR_ID} |
