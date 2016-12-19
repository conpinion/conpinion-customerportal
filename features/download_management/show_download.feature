Feature: Show a download
  In order to see all information about a specific download,
  as a distributor
  i want to display the download

  Scenario: Show a download
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
      | name        | ToDo List Update 1.0.0 |
      | description | Lots of new features!  |
    And that download has the file "todolist_update_1_0_0.zip" attached as file
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I click "Show" in the row containing "ToDo List Update 1.0.0"
    Then I should see "ToDo List Update 1.0.0"
    And I should see "Lots of new features!"
    And I should see "todolist_update_1_0_0.zip"
    And I should see "358 Bytes"
