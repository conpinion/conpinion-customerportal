Feature: Answer an incoming call
  In order to talk with the calling party
  as a user
  I want to answer an incoming call

  @javascript
  Scenario: Answer incoming call
    Given the following admin_user:
      | email       | bob@example.com |
      | family_name | Bob Bachchan    |
    And I am authenticated as admin
    And I am on the home page
    And I receive an incoming call from "Bob Bachchan"
    When I click "Accept"
    Then I should see "In a call with Bob Bachchan"
    Then I should see "Hangup"
    Then I should be on the communication join page
