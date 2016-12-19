Feature: Call other users
  In order to communicate with other users
  as user
  I want to call another user

  Scenario: Admin calls another admin
    Given the following online_admin_user with ID "CALLEE_ID":
      | email       | bob@example.com |
      | family_name | Bob Bachchan    |
    And I am authenticated as admin
    And I am on the home page
    When I click "Communication"
    And I click "Call"
    And I select "Bob Bachchan" from "Callee"
    And I click the button "Call"
    Then the CommunicationCall command is executed with the following parameters:
      | caller.id | %{CURRENT_USER_ID} |
      | callee_id | %{CALLEE_ID}       |

  Scenario: Admin calls another user from the user list
    Given the following online_admin_user with ID "CALLEE_ID":
      | email       | bob@example.com |
      | family_name | Bob Bachchan    |
    And I am authenticated as admin
    And I am on the users page
    When I click "Call" in the row containing "bob@example.com"
    Then the CommunicationCall command is executed with the following parameters:
      | caller.id | %{CURRENT_USER_ID} |
      | callee_id | %{CALLEE_ID}       |
