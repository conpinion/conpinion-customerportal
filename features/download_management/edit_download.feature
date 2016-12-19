Feature: Edit a download
  In order to modify one of the product downloads,
  as an administrator
  i want to edit the download

  @javascript
  Scenario: Edit a download
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product has the following download:
      | name        | ToDo List Update 1.0.0 |
      | description | Lots of new features!  |
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I click "Edit" in the row containing "ToDo List Update 1.0.0"
    And I fill in "Name" with "New name"
    And I fill in "Description" with "New description"
    And I press "Update Download"
    Then I should see "Download was successfully updated"
    And I should see "New name"
    And I should see the following download in the database:
      | name        | New name        |
      | description | New description |
