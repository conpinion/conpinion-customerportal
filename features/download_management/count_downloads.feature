Feature: Count downloads
  In order to track the number of downloads of a product download,
  as an administrator
  i want to count the download number

  @javascript
  Scenario: Count the download
    Given I am authenticated as administrator
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product has the following download:
      | name | ToDo List Update 1.0.0 |
    And that download has the file "todolist_update_1_0_0.zip" attached as file
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I click "Download" in the row containing "ToDo List Update 1.0.0"
    And I should see the following download in the database:
      | name           | ToDo List Update 1.0.0 |
      | download_count | 1                      |
