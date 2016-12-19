Feature: List all users
  In order to get an overview of all the registered users,
  as an administrator
  i want to see a list of all users

  Scenario: List all users
    Given the following customer_user:
      | email | alice@example.com |
    And the following distributor_user:
      | email | bob@example.com |
    And I am authenticated as administrator
    And I am on the home page
    When I click "Users"
    Then I should see "alice@example.com"
    And I should see "customer"
    And I should see "bob@example.com"
    And I should see "distributor"
