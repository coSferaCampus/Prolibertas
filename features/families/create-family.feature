@javascript
Feature: Create family
  As an user
  I want to create families
  In order to add to families list

  Background:
    Given I am loged in like director
    And I click the families button of the menu
    And I click the new family button of the menu

  Scenario: Parameters ok
    When I fill family form with valid parameters
    Then I should see the new family in users list
    And  I should see family created message
