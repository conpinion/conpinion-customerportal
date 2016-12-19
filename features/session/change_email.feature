Feature: A user can change his email address
  In order to use another email account
  as a user
  i want to change my email address

  Scenario: Change email address
    Given I am authenticated as customer with ID "USER_ID"
    And I am on the home page
    When I click "My Account"
    When I click "Change email"
    And I fill in "Current password" with "password"
    And I fill in "New email" with "new_email@example.com"
    And I press "Update email"
    Then I should see the following customer_user in the database:
      | id                | %{USER_ID}            |
      | unconfirmed_email | new_email@example.com |
