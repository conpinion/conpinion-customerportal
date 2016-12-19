Feature: Show account information
  In order to inform myself about the data that is stored about me
  as a user
  I want that display my account info

  Scenario: View account info
    Given the following customer_user:
      | email       | alice@example.com |
      | password    | secret            |
      | family_name | Alice Agarwal     |
    And I go to "the new user session page"
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    When I am on the home page
    And I click "My Account"
    And I click "View"
    Then I should see "Name: Alice Agarwal"
    Then I should see "Email: alice@example.com"
    Then I should see "Role(s): customer"
