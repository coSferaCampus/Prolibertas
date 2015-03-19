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


