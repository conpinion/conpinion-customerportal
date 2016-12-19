Feature: Edit a distributor
  In order to modify an existing distributor,
  as an administrator
  i want to edit a distributor

  Scenario: Edit a distributor
    Given the following distributor:
      | company | ACME International |
    And that distributor embeds the following address:
      | street   | 2640 Rose Avenue |
      | zip_code | PA 19090         |
      | city     | Willow Grove     |
      | country  | US               |
    And that distributor has the following distributor_user as responsible:
      | family_name | Alice Agarwal |
    And I am authenticated as administrator
    And I am on the distributors page
    When I click "Edit" in the row containing "ACME International"
    And I fill in "Company" with "Shenzen Master"
    And I fill in "Street" with "63 Renmin Lu"
    And I fill in "ZIP Code" with "266033"
    And I fill in "City" with "Shandong"
    And I select "China" from "Country"
    And I press "Update Distributor"
    Then I should see "Distributor was successfully updated"
    And I should see "Shenzen Master"
    And I should see "266033, Shandong, China"
