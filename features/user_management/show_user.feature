Feature: Show a user
  In order to see all information about an existing user,
  as an administrator
  i want to display a user

  Scenario: Show a user
    Given the following customer_user:
      | family_name | Alice Agarwal     |
      | email       | alice@example.com |
    And I am authenticated as administrator
    And I am on the users page
    When I click "Show" in the row containing "alice@example.com"
    And I should see "Alice"
    And I should see "Agarwal"
    And I should see "alice@example.com"
