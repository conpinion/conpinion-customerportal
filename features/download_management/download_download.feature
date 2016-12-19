Feature: Download a download
  In order to transfer a download file to my local computer,
  as a distributor
  i want to download the download file

  @javascript
  Scenario: Download a download file
    Given I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And that product is assigned to my distributor
    And that product has the following download:
      | name | ToDo List Update 1.0.0 |
    And that download has the file "todolist_update_1_0_0.zip" attached as file
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I click "Download" in the row containing "ToDo List Update 1.0.0"
    Then I should see a file download matching the file "todolist_update_1_0_0.zip"
