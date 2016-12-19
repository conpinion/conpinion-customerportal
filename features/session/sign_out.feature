Feature: User sign out
  To ensure that only authorized users can access the system
  as a system operator
  I want that the users can sign out after using the system

  Scenario: Sign out
    Given I am authenticated as administrator
    And I am on the home page
    When I click "My Account"
    And I click "Logout"
    Then I should see "Signed out successfully"
