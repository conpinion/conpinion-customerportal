Feature: Delete a download
  In order to remove obsolete downloads
  as an administrator
  i want to delete the download

  @javascript
  Scenario: Delete a download
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product has the following download:
      | name | ToDo List Update 1.0.0 |
    And that product has the following download:
      | name | ToDo List 1.0.0 Manual |
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    When I click "Delete" in the row containing "ToDo List Update 1.0.0"
    And I press "Yes" in the confirmation dialog
    And I should not see "ToDo List Update 1.0.0"
    But I should see "ToDo List 1.0.0 Manual"
