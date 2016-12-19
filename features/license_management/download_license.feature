Feature: Download a license
  In order to install a license,
  as a distributor
  i want to download the license

  @javascript
  Scenario: Download a license
    And I am authenticated as distributor
    And the following customer:
      | name    | Bruce Smith        |
      | company | ACME International |
    And I am the responsible distributor of that customer
    And the following product:
      | name    | ToDo List |
      | version | 1.0.0     |
    And this license for this product to that customer:
      | serial_number | 1234 |
      | machine_code  | abcd |
      | valid_until   | -1   |
    And that license was updated at 1.1.2016 12:00:00
    And I am on the customers page
    When I click "Licenses" in the row containing "ACME International"
    And I click "Download" in the row containing "ToDo List"
    Then I should see a file download with the following contents
      """
      # Distributor License V2.0
      # 01.01.2016 12:00:00
      id = Distributor License V2.0
      vendor = Distributor
      product = ToDo List
      version = 1.0.0
      type = standard
      serial = 1234
      name = Bruce Smith
      company = ACME International
      validity = -1
      machine = abcd
      """
