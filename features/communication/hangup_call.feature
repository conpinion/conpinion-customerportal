Feature: Hangup a call
  In order to terminate a call
  as a user
  I want to hangup

  Background:
    Given the following online_admin_user with ID "CALLEE_ID":
      | email       | bob@example.com |
      | family_name | Bob Bachchan    |
    And I am authenticated as admin
    And I am on the home page

  Scenario: Hangup a call that is not established
    When I call "Bob Bachchan"
    And I click the button "Hangup"
    Then the CommunicationHangup command is executed with the following parameters:
      | peer_id | %{CALLEE_ID} |

  @javascript
  Scenario: Hangup an answered call
    When I call "Bob Bachchan"
    And The call is answered
    And I click "Hangup"
    Then I should see "Call was terminated"
