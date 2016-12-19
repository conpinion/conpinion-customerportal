Feature: Limit the amount of storage space for downloads
  In order to prevent file uploads from exhausting disk space
  as an administrator
  i want to limit the amount of disk space usable for download files

  @javascript
  Scenario: Upload a file of 366 bytes when enough storage space is available
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And there are 366 bytes of file storage available
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I press "New Download"
    And I fill in "Name" with "ToDo List Update 1.0.0"
    And I fill in "Description" with "Lots of new features!"
    And I choose the file "todolist_update_1_0_0.zip" for "File"
    And I press "Create Download"
    Then I should see "Download was successfully created"

  @javascript
  Scenario: Upload a file of 366 bytes when no more storage space is available
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And there are only 100 bytes of file storage available
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I press "New Download"
    And I fill in "Name" with "ToDo List Update 1.0.0"
    And I fill in "Description" with "Lots of new features!"
    And I choose the file "todolist_update_1_0_0.zip" for "File"
    And I press "Create Download"
    Then I should see "File must not exceed storage quota"
