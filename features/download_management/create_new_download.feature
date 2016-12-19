Feature: Create a new download
  In order to supply downloads for a product
  as an administrator
  i want to add a new download to the product

  @javascript
  Scenario: Create a new product
    Given I am authenticated as administrator
    And the following product with ID "PRODUCT_ID":
      | name    | ToDo List |
      | version | 1.0.0     |
    And I am on the products page
    When I click "Downloads" in the row containing "ToDo List"
    And I press "New Download"
    And I fill in "Name" with "ToDo List Update 1.0.0"
    And I fill in "Description" with "Lots of new features!"
    And I choose the file "todolist_update_1_0_0.zip" for "File"
    And I press "Create Download"
    Then I should see "Download was successfully created"
    And I should see "ToDo List Update 1.0.0"
    And I should see "358 Bytes"
    And I should see the following download in the database:
      | name           | ToDo List Update 1.0.0    |
      | description    | Lots of new features!     |
      | file_file_name | todolist_update_1_0_0.zip |
      | file_file_size | 358                       |
      | product_id     | %{PRODUCT_ID}             |
      | download_count | 0                         |
