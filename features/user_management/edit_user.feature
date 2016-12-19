Feature: Edit a user
  In order to modify an existing user,
  as an administrator
  i want to edit a user

  Scenario: Edit a user
    Given the following customer_user:
      | email | alice@example.com |
    And I am authenticated as administrator
    And I am on the users page
    When I click "Edit" in the row containing "alice@example.com"
    And I fill in "Name" with "Bob Bachchan"
    And I press "Update User"
    Then I should see "User was successfully updated"
    And I should see "Bob Bachchan"
