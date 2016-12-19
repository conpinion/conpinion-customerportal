Feature: Signal incoming call
  In order to react to an incoming call
  as a user
  I want to see a toast popup with information about the call

  @javascript
  Scenario: Display a toast when a call comes in
    Given the following admin_user with ID "CALLER_ID":
      | email       | bob@example.com |
      | family_name | Bob Bachchan    |
    And I am authenticated as admin
    And I am on the home page
    When I receive an incoming call from "Bob Bachchan"
    Then I should see a toast containing "Incoming call from Bob Bachchan"
