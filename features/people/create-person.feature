@javascript
Feature: Create person
  As an user
  I want to create people
  In order to add to people list

  Background: 
    Given I am loged in like user
    Given I visit new person page

  Scenario: Parameters ok
    When I fill person form with valid parameters
    Then I should see the new person in people list
    And  I should see person created message

  Scenario: Error parameters
    When I fill person form with invalid parameters
    Then I should see the errors in the form

  Scenario: Correct error parameters on InputName
    When I fill person form with invalid parameters
    And  I fill input "InputName" with "Name"
    Then I should not see error on "InputName"

  Scenario: Correct error parameters on InputPassword
    When I fill person form with invalid parameters
    And  I fill input "InputPassword" with "Password"
    Then I should not see error on "InputPassword"

  Scenario: Correct error parameters on InputFull_name
    When I fill person form with invalid parameters
    And  I fill input "InputFull_name" with "Full_name"
    Then I should not see error on "InputFull_name"


