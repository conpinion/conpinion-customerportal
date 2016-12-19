Feature: Edit a customer
  In order to modify one of my customers,
  as a distributor
  i want to edit the customer

  Scenario: Edit a distributor
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And that customer embeds the following address:
      | street   | 2640 Rose Avenue |
      | zip_code | PA 19090         |
      | city     | Willow Grove     |
      | country  | US               |
    And I am on the customers page
    When I click "Edit" in the row containing "ACME International"
    And I fill in "Name" with "Ling Chung"
    And I fill in "Company" with "Shenzen Master"
    And I fill in "Street" with "63 Renmin Lu"
    And I fill in "ZIP Code" with "266033"
    And I fill in "City" with "Shandong"
    And I select "China" from "Country"
    And I press "Update Customer"
    Then I should see "Customer was successfully updated"
    And I should see "Ling Chung"
    And I should see "Shenzen Master"
    And I should see "266033, Shandong, China"
