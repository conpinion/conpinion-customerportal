Feature: Edit a user
  In order to prevent users from accessing the system,
  as an administrator
  i want to delete a user

  @javascript
  Scenario: Delete a user
    Given the following customer_user:
      | email | alice@example.com |
    And I am authenticated as administrator
    And I am on the users page
    When I click "Delete" in the row containing "alice@example.com"
    And I press "Yes" in the confirmation dialog
    Then I should see "User was successfully deleted"
    And I should not see "Bob Bachchan"
