Feature: List all downloads of a product
  In order to get an overview of all available product downloads
  as a distributor
  i want to see a list of all downloads

  Scenario: List all downloads
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
    And that product has the following download:
      | name | ToDo List 1.0.0 Manual |
    And that download has the file "todolist_manual_1_0_0.txt" attached as file
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    Then I should see "ToDo List Update 1.0.0"
    And I should see "358 Bytes"
    And I should see "ToDo List 1.0.0 Manual"
    And I should see "7 Bytes"
