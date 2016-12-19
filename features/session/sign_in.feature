@javascript
Feature: User sign in
  To ensure that only authorized users can access the system
  as a system operator
  I want that all the users need to authorize themselves with their email and password

  Scenario: Sign in with a valid email and password
    Given the following customer_user:
      | email       | alice@example.com |
      | password    | secret            |
      | family_name | Alice Agarwahl    |
    When I go to "the new user session page"
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    Then I should see "Hello Alice Agarwahl!"
    And I should see "Signed in successfully"

  Scenario: Sign in with an invalid password
    Given the following customer_user:
      | email    | alice@example.com |
      | password | secret            |
    When I go to "the new user session page"
    And I fill in "Email" with "alice@example.com"
    And I fill in "Password" with "wrong_password"
    And I press "Sign in"
    Then I should see "Invalid Email or password"
