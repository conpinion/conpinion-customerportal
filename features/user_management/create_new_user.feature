Feature: Create a new a user
  In order to provide a new user access to the system,
  as an administrator
  i want to create a new user

  Scenario: Create a new user
    Given I am authenticated as administrator
    And I am on the users page
    When I press "New User"
    And I fill in "Name" with "Alice Agarwal"
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Repeat password" with "secret"
    And I select "customer" from "Role"
    And I press "Create User"
    Then I should see "User was successfully created"
    And I should see "Alice Agarwal"
    And I should see the following user in the database:
      | family_name | Alice Agarwal     |
      | email       | alice@example.com |
    And the user "alice@example.com" has the role "customer"
