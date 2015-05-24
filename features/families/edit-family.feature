@javascript
Feature: Edit family
  As an user
  I want to edit family
  In order to update family data

Background:
  Given There are 1 families in the platform
  And I am loged in like director
  And I click the families button of the menu
  And I click the view icon of a family in families list view

Scenario: Visit family edit form
  When I click the family edit button
  Then I should see the family edit form

Scenario: update family form
  When I update the family form
  Then I should see the family updated

Scenario: Update family form with no text
  When I fill person update family form with invalid parameters
  Then I should see the errors in the update form
