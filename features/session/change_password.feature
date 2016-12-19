Feature: A user can change his password
  In order to increase the security of my account
  as a user
  i want to change my password frequently

  Scenario: Change password
    Given I am authenticated as customer
    And I am on the home page
    When I click "My Account"
    And I click "Change password"
    And I fill in "Current password" with "password"
    And I fill in "New password" with "new_password"
    And I fill in "Repeat password" with "new_password"
    And I press "Update password"
    Then I should see "Your password was successfully updated"
    When I click "My Account"
    And I click "Logout"
    And I fill in "Email" with "currentuser@example.com"
    And I fill in "Password" with "new_password"
    And I press "Sign in"
    Then I should see "Signed in successfully"
