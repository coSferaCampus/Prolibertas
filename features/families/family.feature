@javascript
Feature: Family Show
  As an user
  I want to see one family page
  In order to display all data of this family

  Background:
    Given There are 3 families in the platform
    And I am loged in like director
    And I click the families button of the menu

  Scenario: Open family view
    When I click the view icon of a family in families list view
    Then I should go to a view of this family

  Scenario: Remove family
    When I click the remove button in family view
    Then I should remove this family
    And  I should see a remove family success message
