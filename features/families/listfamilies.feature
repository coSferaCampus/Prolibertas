@javascript
Feature: Families
  As an user
  I want to see families list
  In order to assign services to families

  Scenario: Families list
    Given There are 3 families in the platform
    And I am loged in like director
    When I click the families button of the menu
    Then I should see the list of the families
